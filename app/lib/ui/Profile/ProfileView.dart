import 'package:app/services/AuthService.dart';
import 'package:app/services/FirestoreService.dart';
import 'package:app/ui/Profile/FavoritesView.dart';
import 'package:app/ui/Profile/RecenlyView.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../ViewModels/userViewModel.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late User? _user;
  String? _firstName;
  String? _lastName;
  String? _email;
  int? _rewardPoints;
  String? _profilePictureUrl;
  Position? userLocation;

  @override
  Widget build(BuildContext context) {
    var userDetais = ref.watch(userProvider);

    return userDetais.when(
      data: (data) {
        _firstName = data.data()!["firstName"];
        _lastName = data.data()!["lastName"];
        _profilePictureUrl = data.data()!["profilePictureUrl"];
        _email = data.data()!["email"];
        _rewardPoints = data.data()!["rewardPoints"];
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(400.0),
            child: AppBar(
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
                          child: CircleAvatar(
                        radius: 60,
                        backgroundImage: _profilePictureUrl != null
                            ? NetworkImage(_profilePictureUrl!)
                            : const AssetImage(
                                'assets/profile_pic_g.png',
                              ) as ImageProvider,
                      )),
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 7),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      FirestoreService().updateProfilePicture();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      children: [
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
                const SizedBox(height: 7),
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
                                decoration: const InputDecoration(
                                    labelText: 'First Name'),
                                onChanged: (value) {
                                  _firstName = value;
                                },
                              ),
                              TextFormField(
                                initialValue: _lastName,
                                decoration: const InputDecoration(
                                    labelText: 'Last Name'),
                                onChanged: (value) {
                                  _lastName = value;
                                },
                              ),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                FirestoreService().updateUserProfile(
                                  _firstName,
                                  _lastName,
                                );
                                Navigator.pop(context);
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
                    child: const Row(
                      children: [
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
                const SizedBox(height: 7),
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
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            onChanged: (value) {
                              _email = value;
                            },
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                AuthService().sendEmailVerification();
                                Navigator.pop(context);
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
                    child: const Row(
                      children: [
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
                const SizedBox(height: 7),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => RecentlyView()));
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
                    child: const Row(
                      children: [
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
                const SizedBox(height: 7),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavoritesView(),
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
                    child: const Row(
                      children: [
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
                const SizedBox(height: 7),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      AuthService().signOut();
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
                    child: const Row(
                      children: [
                        SizedBox(width: 24),
                        Icon(
                          Icons.logout,
                          size: 40.0,
                        ),
                        SizedBox(width: 20),
                        Text('Logout',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stack) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
