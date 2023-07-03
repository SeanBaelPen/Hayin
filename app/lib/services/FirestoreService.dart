import 'dart:io';

import 'package:app/models/review_model..dart';
import 'package:app/services/AuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirestoreService {
  void createUser(firstName, lastName) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getID())
        .set({
      'email': FirebaseAuth.instance.currentUser!.email,
      'firstName': firstName,
      'lastName': lastName,
      'profilePictureUrl': '',
    });
  }

  Future<void> updateUserProfile() async {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getID());
    final userData = (await userDoc.get()).data();
  }

  Future<void> updateProfilePicture() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = await FirebaseStorage.instance
          .ref('profile_pictures/${AuthService().getID()}.png')
          .putFile(File(pickedFile.path));

      final imageUrl = await imageFile.ref.getDownloadURL();

      FirebaseFirestore.instance
          .collection("users")
          .doc(AuthService().getID())
          .update({
        "profilePictureUrl": imageUrl,
      });
    }
  }

  void submitReview(ReviewModel review) {
    FirebaseFirestore.instance.collection("ratings").doc().set({
      'rating': review.rating,
      'review': review.review,
      'userName': review.userName,
      'userImg': review.userImg,
      'restaurantId': review.restaurantId,
      'timestamp': review.timestamp,
    });
  }
}
