import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StreamProvider<User?> authStateProvider = StreamProvider((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
