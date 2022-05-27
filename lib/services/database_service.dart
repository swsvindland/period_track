import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import '../models/preferences.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var date = DateTime.now();

  Stream<Preferences> streamPreferences(String id) {
    try {
      return _db
          .collection('preferences')
          .doc(id)
          .snapshots()
          .map((snap) => Preferences.fromMap(snap.data()!));
    } catch (err) {
      return Stream.error(err);
    }
  }

  Future<void> updatePreferences(String id, Preferences preferences) {
    try {
      return _db
          .collection('preferences')
          .doc(id)
          .set(Preferences.toMap(preferences));
    } catch (err) {
      return Future.error(err);
    }
  }
}
