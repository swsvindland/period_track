import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import "package:os_detect/os_detect.dart" as platform;
import 'package:period_track/models/note.dart';

void setFCMData(
  FirebaseFirestore db,
  FirebaseMessaging fcm,
  User user,
) async {
  String? fcmToken = await fcm.getToken();

  if (fcmToken != null) {
    var tokenRef = db.collection('tokens').doc(user.uid);
    tokenRef.set({
      'created': FieldValue.serverTimestamp(),
      'platform': platform.operatingSystem,
      'token': fcmToken
    });
  }
}

void createDefaultPreferences(FirebaseFirestore db, User user) async {
  DocumentSnapshot snapshot =
      await db.collection('preferences').doc(user.uid).get();

  if (!snapshot.exists) {
    snapshot.reference.set({
      'defaultCycleLength': 28,
      'start':
          DateTime.parse('2000-01-01 ${7.toString().padLeft(2, '0')}:00:00'),
      'disclaimer': false
    });
  }
}

void updateUserData(FirebaseFirestore db, User user) async {
  DocumentReference ref = db.collection('users').doc(user.uid);

  return ref.set({
    'uid': user.uid,
    'email': user.email,
    'displayName': user.displayName,
    'lastSeen': DateTime.now()
  });
}

int computeMenstrualLength(int defaultCycleLength, List<DateTime> periodStarts) {
  if (periodStarts.length < 3) {
    return defaultCycleLength;
  }

  periodStarts.sort((a, b) {
    return a.compareTo(b);
  });
  var temp = periodStarts[0];
  var sum = 0;

  for (int i = 1; i < periodStarts.length - 1; ++i) {
    sum += periodStarts[i].difference(temp).inDays;
    temp = periodStarts[i];
  }


  return (sum / (periodStarts.length - 2)).ceil();
}

int computePeriodLength(int cycleLength) {
  var computed = (cycleLength / 5).ceil();

  if (computed < 4) return 4;
  if (computed > 8) return 8;
  return computed;
}

int computeOvulationLength(int cycleLength) {
  int computed = (cycleLength / 2).ceil();

  return computed;
}

int computeFertilityLength(int cycleLength) {
  var computed = (cycleLength / 3).ceil();

  if (computed < 4) return 4;
  if (computed > 8) return 6;
  return computed;
}

Map<DateTime, DateTime> computeFertility(int cycleLength, Map<DateTime, DateTime> ovulationDate) {
  List<DateTime> output = [];
  var length = computeFertilityLength(cycleLength);

  ovulationDate.keys.toList().forEach((element) {
    // potential fertility after ovulation so the negative one is to show the day after
    for (int i = -1; i < length - 1; ++i) {
      output.add(element.subtract(Duration(days: i)));
    }
  });

  return {for (var e in output) DateUtils.dateOnly(e): DateUtils.dateOnly(e)};
}

Map<DateTime, DateTime> computeNextFewYearsOfCycles(int cycleLength, Map<DateTime, DateTime> periodStartDates) {
  var sorted = Map.fromEntries(
      periodStartDates.entries.toList()
        ..sort((e1, e2) => e1.value.compareTo(e2.value)));

  if (sorted.isEmpty) {
    return {};
  }

  int periodLength = computePeriodLength(cycleLength);
  DateTime temp = sorted.keys.last;
  List<DateTime> output = [];

  for (int i = 0; i < 48; ++i) {
    temp = temp.add(Duration(days: cycleLength));
    for (int j = 0; j < periodLength; ++j) {
      output.add(temp.add(Duration(days: j)));
    }
  }

  return {for (var e in output) DateUtils.dateOnly(e): DateUtils.dateOnly(e)};
}

class Cycle {
  final DateTime date;
  final int length;

  Cycle({ required this.date, required this.length});
}

List<Cycle> computeMenstrualLengthsForGraph(int cycleLength, List<DateTime> periodStarts) {
  periodStarts.sort((a, b) {
    return a.compareTo(b);
  });

  var temp = periodStarts[0];
  List<Cycle> output = [];

  for (int i = 1; i < periodStarts.length - 1; ++i) {
    output.add(Cycle(date: periodStarts[i], length: periodStarts[i].difference(temp).inDays));

    temp = periodStarts[i];
  }

  var keyedPeriodStarts = { for (var e in periodStarts) DateUtils.dateOnly(e) : DateUtils.dateOnly(e)};

  var predictedNextPeriodStart = computeNextFewYearsOfCycles(cycleLength, keyedPeriodStarts).entries.first.value;

  output.add(Cycle(date: periodStarts[periodStarts.length - 1], length: predictedNextPeriodStart.difference(periodStarts[periodStarts.length - 1]).inDays));

  return output;
}

List<Cycle> computeFlowLengthsForGraph(int cycleLength, List<NoteModel> notes) {
  notes.sort((a, b) {
    return a.date.compareTo(b.date);
  });

  List<Cycle> output = [];

  for (int i = 0; i < notes.length - 1; ++i) {
    if (!notes[i].periodStart) {
      continue;
    }
    var count = 1;
    for (int j = i + 1; j < notes.length; ++j) {
      if (notes[j].periodStart) {
        break;
      }

      if (notes[j].flow != null) {
        count++;
      }
    }

    output.add(Cycle(date: notes[i].date, length: count));
  }

  return output;
}