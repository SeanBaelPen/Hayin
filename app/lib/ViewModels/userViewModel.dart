import 'package:app/services/AuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StreamProvider<DocumentSnapshot<Map<String, dynamic>>> userProvider =
    StreamProvider((ref) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(AuthService().getID())
      .snapshots();
});
