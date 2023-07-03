import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeStreamProvider<User?> authStateProvider =
    StreamProvider.autoDispose((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
