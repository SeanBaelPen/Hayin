import 'package:app/ui/catalogue_format.dart';
import 'package:app/ui/filter_ui.dart';
import 'package:app/ui/location_ui.dart';
import 'package:app/ui/profile_ui.dart';
import 'package:app/ui/restaurant_details.dart';
import 'package:app/ui/reward_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  Position? userLocation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      // Home page is tapped
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

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getCollectionStream() {
    return firestore.collection('restaurants').snapshots();
  }

  Stream<QuerySnapshot> getFoodStallsStream() {
    return firestore.collection('foodStalls').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(400.0),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.filter_list,
              size: 50,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterPage(),
                ),
              );
            },
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
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/profile_pic_g.png',
                  ),
                ),
                const Positioned(
                  top: 270,
                  left: 0,
                  right: 0,
                  child: Text(
                    'Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Sans Serif',
                      color: Colors.white,
                    ),
                  ),
                ),
                const Positioned(
                  top: 300,
                  left: 0,
                  right: 0,
                  child: Text(
                    'Where do you want to eat today?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Sans Serif',
                      color: Colors.white,
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
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(
                    child: Text(
                      'Restaurants',
                      style: TextStyle(
                        fontFamily: 'Monserrat',
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Food Stalls',
                      style: TextStyle(
                        fontFamily: 'Monserrat',
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              // const Text(
              //   'Popular Resturants',
              //   textAlign: TextAlign.start,
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              // StreamBuilder<QuerySnapshot>(
              //   stream: getCollectionStream(),
              //   builder: (BuildContext context,
              //       AsyncSnapshot<QuerySnapshot> snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const CircularProgressIndicator();
              //     }
              //     if (snapshot.hasError) {
              //       return Text('Error: ${snapshot.error}');
              //     }
              //     return ListView.builder(
              //       shrinkWrap: true,
              //       physics: const NeverScrollableScrollPhysics(),
              //       itemCount: snapshot.data!.docs.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         DocumentSnapshot document = snapshot.data!.docs[index];
              //         return Catalogue(
              //           image: document['image'],
              //           name: document['name'],
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) =>
              //                     RestaurantDetails(), // Replace NewPage with your desired page
              //               ),
              //             );
              //           },
              //         );
              //       },
              //     );
              //   },
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 13.0, left: 5, right: 5),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: getCollectionStream(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot document =
                                  snapshot.data!.docs[index];
                              return Catalogue(
                                image: document['image'],
                                name: document['name'],
                                categories: document['categories'],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RestaurantDetails(
                                        restaurantName: document['name'],
                                        restaurantImage: document['image'],
                                      ), // Replace NewPage with your desired page
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: getFoodStallsStream(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot document =
                                  snapshot.data!.docs[index];
                              List<dynamic> categories = document['categories'];
                              return Catalogue(
                                image: document['image'],
                                name: document['name'],
                                categories: categories,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RestaurantDetails(
                                        restaurantName: document['name'],
                                        restaurantImage: document['image'],
                                      ), // Replace NewPage with your desired page
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
