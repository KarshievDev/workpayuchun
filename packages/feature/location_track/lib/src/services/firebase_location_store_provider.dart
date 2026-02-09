import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseLocationStoreProvider {
  Future sendLocationToFirebase(uid, location) async {
    return FirebaseFirestore.instance.collection('hrm_employee_track').doc('$uid').set(location).catchError((e) {
      debugPrint(e.toString());
    });
  }
}
