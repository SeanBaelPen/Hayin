import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  child: Text('My Profile'),
                ),
                Positioned(
                  child: Image.asset('assets/profile_pic_g.png'),
                ),
                const Positioned(
                  child: Text('Name'),
                )
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
              onPressed: () {},
              icon: const Icon(
                Icons.camera_alt_outlined,
                size: 24.0,
              ),
              label: const Text(
                'Edit Profile Picutre',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.app_registration_rounded,
                size: 24.0,
              ),
              label: const Text(
                'Edit Profile Name',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
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
