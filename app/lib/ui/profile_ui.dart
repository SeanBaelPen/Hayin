import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  //final String? email;

  const ProfilePage({Key? key}) : super(key: key);

  get email => null;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? _user;
  String? _firstName;
  String? _lastName;
  String? _email;
  int? _rewardPoints;
  String? _profilePictureUrl;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _loadUserProfile();
    }
  }

  Future<void> _loadUserProfile() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .get();

    setState(() {
      _firstName = userData['firstName'];
      _lastName = userData['lastName'];
      _email =
          userData['email'] ?? widget.email; // Use widget.email if available
      _rewardPoints = userData['rewardPoints'];
      _profilePictureUrl = userData['profilePictureUrl'];
    });
  }

  Future<void> _loadUserData() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .get();

    setState(() {
      _firstName = userData['firstName'];
      _lastName = userData['lastName'];
    });
  }

  Future<void> _updateUserProfile() async {
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(_user!.uid);
    final userData = (await userDoc.get()).data() as Map<String, dynamic>?;

    if (userData != null) {
      userData['firstName'] = _firstName;
      userData['lastName'] = _lastName;
      userData['profilePictureUrl'] = _profilePictureUrl;
      userData['_rewardPoints'] = _rewardPoints;
      // Add any other fields that need to be updated

      if (_email != null) {
        userData['email'] = _email;
        // Send email verification link
        await _user!.updateEmail(_email!);
        await _user!.sendEmailVerification();
      }

      await userDoc.set(userData, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
      await _loadUserData(); // Fetch the latest data after updating
    }
  }

  Future<void> _updateProfilePicture() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = await firebase_storage.FirebaseStorage.instance
          .ref('profile_pictures/${_user!.uid}.png')
          .putFile(File(pickedFile.path));

      final imageUrl = await imageFile.ref.getDownloadURL();

      setState(() {
        _profilePictureUrl = imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(400.0),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {},
          ),
          flexibleSpace: Container(
            height: 430,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(17),
                bottomRight: Radius.circular(17),
              ),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 133, 74, 1),
                  Color.fromRGBO(255, 62, 53, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 45,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'My Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: _profilePictureUrl != null
                        ? Image.network(_profilePictureUrl!)
                        : Image.asset(
                            'assets/profile_pic_g.png',
                            width: 120,
                            height: 120,
                          ),
                  ),
                ),
                Positioned(
                  top: 290,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Name: $_firstName $_lastName',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _updateProfilePicture,
              icon: Icon(
                Icons.camera_alt_outlined,
                size: 50.0,
              ),
              label: Text(
                'Edit Profile Picture',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Show a dialog to update first name and last name
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Update Name'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          initialValue: _firstName,
                          decoration: InputDecoration(labelText: 'First Name'),
                          onChanged: (value) {
                            _firstName = value;
                          },
                        ),
                        TextFormField(
                          initialValue: _lastName,
                          decoration: InputDecoration(labelText: 'Last Name'),
                          onChanged: (value) {
                            _lastName = value;
                          },
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _updateUserProfile();
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(
                Icons.app_registration_rounded,
                size: 24.0,
              ),
              label: const Text(
                'Edit Profile Name',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Show a dialog to update email
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Verify Email'),
                    content: TextFormField(
                      initialValue: _email,
                      decoration: InputDecoration(labelText: 'Email'),
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _updateUserProfile();
                        },
                        child: Text('Verify'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(
                Icons.email_outlined,
                size: 24.0,
              ),
              label: const Text(
                'Verify Email',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.access_time_rounded,
                size: 24.0,
              ),
              label: const Text(
                'Recently Viewed',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                size: 24.0,
              ),
              label: const Text(
                'Favorites',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
