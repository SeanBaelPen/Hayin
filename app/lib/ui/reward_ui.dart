import 'package:app/ui/location_ui.dart';
import 'package:app/ui/profile_ui.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'home_ui.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({Key? key}) : super(key: key);

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  Position? userLocation;
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      userLocation = position;
    });
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      // Home page is tapped
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
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
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(255, 133, 74, 1),
                Color.fromRGBO(255, 62, 53, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Points',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Image.asset(
                          'assets/namecard.png',
                        ),
                      ),
                      Positioned(
                        top: 15,
                        left: 15,
                        child: Image.asset(
                          'assets/profile_pic_g.png',
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const Positioned(
                        left: 105,
                        top: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'AVAILABLE POINTS',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              '1040',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: Image.asset(
                          'assets/point_history_btn.png',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Image.asset(
                          'assets/grey_rectangle.png',
                        ),
                      ),
                      const Positioned(
                        top: 0,
                        left: 20,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'How it works',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 90,
                        left: 25,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/orange_star.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              'Image 1 Text',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        left: 25,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/shopping_bag.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              'Image 2 Text',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 25,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/crown.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              'Image 3 Text',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Redeem your points',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Image.asset(
                          'assets/redeemPts1.png',
                        ),
                      ),
                      Positioned(
                        left: 17,
                        child: Image.asset(
                          'assets/redeemPts2.png',
                        ),
                      ),
                      Positioned(
                        left: 25,
                        child: Image.asset(
                          'assets/pizzaDragon.png',
                          width: 100,
                        ),
                      ),
                      const Positioned(
                        left: 180,
                        child: Text(
                          'Pizza Dragon',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Image.asset(
                          'assets/redeemPts1.png',
                        ),
                      ),
                      Positioned(
                        left: 17,
                        child: Image.asset(
                          'assets/redeemPts2.png',
                        ),
                      ),
                      Positioned(
                        top: .1,
                        left: 25,
                        child: Image.asset(
                          'assets/jakeu_cafe_logo.png',
                          width: 100,
                        ),
                      ),
                      const Positioned(
                        left: 185,
                        child: Text(
                          'Jakeu Cafe',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Image.asset(
                          'assets/redeemPts1.png',
                        ),
                      ),
                      Positioned(
                        left: 17,
                        child: Image.asset(
                          'assets/redeemPts2.png',
                        ),
                      ),
                      Positioned(
                        left: 25,
                        child: Image.asset(
                          'assets/master_buffalo_logo.png',
                          width: 100,
                        ),
                      ),
                      const Positioned(
                        left: 170,
                        child: Text(
                          'Master Buffalo',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
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
