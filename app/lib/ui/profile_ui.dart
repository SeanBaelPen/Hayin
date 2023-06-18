import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
      _email = userData['email'];
      _rewardPoints = userData['rewardPoints'];
      _profilePictureUrl = userData['profilePictureUrl'];
    });
  }

  Future<void> _updateUserProfile() async {
    final userData = {
      'firstName': _firstName,
      'lastName': _lastName,
      'email': _email,
      'rewardPoints': _rewardPoints,
      'profilePictureUrl': _profilePictureUrl,
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .set(userData, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated successfully')),
    );
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
        preferredSize: Size.fromHeight(400.0),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {},
          ),
          flexibleSpace: Container(
            height: 430,
            decoration: BoxDecoration(
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
                  child: Text('My Profile'),
                ),
                Positioned(
                  child: _profilePictureUrl != null
                      ? Image.network(_profilePictureUrl!)
                      : Image.asset('assets/profile_pic_g.png'),
                ),
                Positioned(
                  child: Text('Name: $_firstName $_lastName'),
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
              label: Text(
                'Edit Profile Name',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Show a dialog to update email
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Update Email'),
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
                        child: Text('Save'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(
                Icons.email_outlined,
                size: 24.0,
              ),
              label: Text(
                'Verify Email',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.access_time_rounded,
                size: 24.0,
              ),
              label: Text(
                'Recently Viewed',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                size: 24.0,
              ),
              label: Text(
                'Favorites',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
