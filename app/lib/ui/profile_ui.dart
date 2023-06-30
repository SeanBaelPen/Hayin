import 'package:app/ui/location_ui.dart';
import 'package:app/ui/reward_ui.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'home_ui.dart';

class ProfilePage extends StatefulWidget {
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
  Position? userLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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
    final userData = (await userDoc.get()).data();

    if (userData != null) {
      // fields that need to be updated
      userData['firstName'] = _firstName;
      userData['lastName'] = _lastName;
      userData['profilePictureUrl'] = _profilePictureUrl;
      userData['_rewardPoints'] = _rewardPoints;

      if (_email != null) {
        userData['email'] = _email;
        // Send email verification link
        await _user!.updateEmail(_email!);
        await _user!.sendEmailVerification();
      }

      await userDoc.set(userData, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
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

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      userLocation = position;
    });
  }

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == 0) {
      // Home page is tapped
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else if (index == 2) {
      if (userLocation != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LocationPage(
              destination:
                  LatLng(userLocation!.latitude, userLocation!.longitude),
            ),
          ),
        );
      }
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RewardPage(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
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
                const Positioned(
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
                      style: const TextStyle(
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
      body: Column(
        children: [
          SizedBox(height: 7),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _updateProfilePicture,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                primary: Colors.white,
                onPrimary: Colors.black,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 24),
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 40.0,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Edit Profile Picture',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 7),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                // Show a dialog to update first name and last name
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Update Name'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          initialValue: _firstName,
                          decoration:
                              const InputDecoration(labelText: 'First Name'),
                          onChanged: (value) {
                            _firstName = value;
                          },
                        ),
                        TextFormField(
                          initialValue: _lastName,
                          decoration:
                              const InputDecoration(labelText: 'Last Name'),
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
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                primary: Colors.white,
                onPrimary: Colors.black,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 24),
                  Icon(
                    Icons.app_registration_rounded,
                    size: 40.0,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Edit Profile Name',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 7),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                //Show a dialog to verify email
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 8),
                        const Text('Verify Email'),
                      ],
                    ),
                    content: TextFormField(
                      initialValue: _email,
                      decoration: const InputDecoration(labelText: 'Email'),
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
                        child: const Text('Verify'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                primary: Colors.white,
                onPrimary: Colors.black,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 24),
                  Icon(
                    Icons.email_outlined,
                    size: 40.0,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Verify Email',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 7),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                primary: Colors.white,
                onPrimary: Colors.black,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 24),
                  Icon(
                    Icons.access_time_rounded,
                    size: 40.0,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Recently Viewed',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 7),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                primary: Colors.white,
                onPrimary: Colors.black,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 24),
                  Icon(
                    Icons.favorite_border,
                    size: 40.0,
                  ),
                  SizedBox(width: 20),
                  Text('Favorites',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ],
              ),
            ),
          ),
          SizedBox(height: 7),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_circle),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_outlined),
            label: 'Rewards',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
