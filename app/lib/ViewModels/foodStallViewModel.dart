import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StreamProvider<QuerySnapshot<Map<String, dynamic>>> foodStallProvider =
    StreamProvider((ref) {
  return FirebaseFirestore.instance.collection('foodStalls').snapshots();
});
