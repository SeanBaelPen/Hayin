import 'package:app/ViewModels/restaurantsViewModel.dart';
import 'package:app/services/FirestoreService.dart';
import 'package:app/ui/Home/HomeView.dart';
import 'package:app/ui/Profile/ProfileView.dart';
import 'package:app/ui/Rewards/RewardView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../ViewModels/authViewModel.dart';
import '../services/GeolocatorService.dart';
import 'Auth/welcome_ui.dart';
import 'Location/location_ui.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;
  bool isRedeemed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authState = ref.watch(authStateProvider);
    var restaurants = ref.watch(streamProvider);

    var location = ref.watch(locationProvider);
    print(location);

    return Scaffold(
      body: authState.when(data: (data) {
        if (data?.uid == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WelcomePage()));
          });
        }
        return restaurants.when(
          data: (restauData) {
            return Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: [
                      const HomeView(),
                      const ProfilePage(),
                      LocationPage(
                        destination: LatLng(
                            ref.read(locationProvider)!.latitude,
                            ref.read(locationProvider)!.longitude),
                      ),
                      //SizedBox(),
                      const RewardPage(),
                    ],
                  ),
                ),
                BottomNavigationBar(
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
                  onTap: (index) async {
                    setState(() {
                      _selectedIndex = index;
                    });
                    await ref
                        .read(locationProvider.notifier)
                        .getCurrentLocation();
                    double minDistance = double.infinity;

                    var closest;
                    for (var restaurant in restauData.docs) {
                      var distance = Geolocator.distanceBetween(
                          location!.latitude,
                          location.longitude,
                          restaurant.data()['destinationLocation'].latitude,
                          restaurant.data()['destinationLocation'].longitude);
                      if (distance < minDistance) {
                        minDistance = distance;
                        closest = restaurant;
                      }
                    }
                    if (minDistance <= 10) {
                      // ignore: use_build_context_synchronously

                      if (!isRedeemed) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return Center(
                                child: Card(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 210,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "You are near ${closest.data()['name']}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "+5 Points",
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Fluttertoast.showToast(
                                                  msg: "Points Claimed");
                                              FirestoreService().claimPoints();
                                              isRedeemed = true;
                                              Navigator.pop(builder);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(
                                                  double.infinity, 50),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: Text(
                                              "Claim Points",
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                    }
                  },
                ),
              ],
            );
          },
          error: (error, stack) {
            return Center(
              child: Text(error.toString()),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }, error: (error, stack) {
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
