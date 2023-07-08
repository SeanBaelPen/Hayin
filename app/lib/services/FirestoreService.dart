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
      '_rewardPoints': 0,
      'favorites': [],
      "recentlyViewed": [],
    });
  }

  Future<void> updateUserProfile(fName, lName) async {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getID())
        .update({
      'firstName': fName,
      'lastName': lName,
    });
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

  void redeemItem(pointsToDeduct) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(AuthService().getID())
        .update({
      '_rewardPoints': FieldValue.increment(-pointsToDeduct),
    });
  }

  void claimPoints() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(AuthService().getID())
        .update({
      '_rewardPoints': FieldValue.increment(5),
    });
  }

  void addFavorite(restaurantId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(AuthService().getID())
        .update({
      'favorites': FieldValue.arrayUnion([restaurantId]),
    });
  }

  void removeFavorite(restaurantId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(AuthService().getID())
        .update({
      'favorites': FieldValue.arrayRemove([restaurantId]),
    });
  }

  void addRecentlyViewed(restaurantId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(AuthService().getID())
        .update({
      'recentlyViewed': FieldValue.arrayUnion([restaurantId]),
    });
  }
}
