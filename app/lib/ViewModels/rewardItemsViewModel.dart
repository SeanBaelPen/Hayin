import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StreamProvider<QuerySnapshot<Map<String, dynamic>>> rewardItemProvider =
    StreamProvider((ref) {
  return FirebaseFirestore.instance.collection('rewardItems').snapshots();
});
