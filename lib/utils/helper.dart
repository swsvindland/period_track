import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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


  return (sum / periodStarts.length).ceil();
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
  if (computed > 8) return 8;
  return computed;
}

Map<DateTime, DateTime> computeNextFewYearsOfCycles(int cycleLength, List<DateTime> periodStartDates) {
  periodStartDates.sort((a, b) => a.compareTo(b));

  int periodLength = computePeriodLength(cycleLength);
  DateTime temp = periodStartDates.last;
  List<DateTime> output = [];

  for (int i = 0; i < 48; ++i) {
    temp = temp.add(Duration(days: cycleLength));
    for (int j = 0; j < periodLength; ++j) {
      output.add(temp.add(Duration(days: j)));
    }
  }

  return {for (var e in output) e: e};
}

class Cycle {
  final DateTime date;
  final int length;

  Cycle({ required this.date, required this.length});
}

List<Cycle> computeMenstrualLengthsForGraph(List<DateTime> periodStarts) {
  periodStarts.sort((a, b) {
    return a.compareTo(b);
  });

  var temp = periodStarts[0];
  List<Cycle> output = [];

  for (int i = 1; i < periodStarts.length - 1; ++i) {
    output.add(Cycle(date: periodStarts[i], length: periodStarts[i].difference(temp).inDays));

    temp = periodStarts[i];
  }


  return output;
}