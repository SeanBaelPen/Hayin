import 'package:app/common/MenuCards/catalogue_format.dart';
import 'package:app/services/GeolocatorService.dart';
import 'package:app/ui/filter_ui.dart';
import 'package:app/ui/Home/HomeView.dart';
import 'package:app/ui/Location/location_ui.dart';
import 'package:app/ui/Profile/ProfileView.dart';
import 'package:app/common/MenuCards/restaurant_details.dart';
import 'package:app/ui/Rewards/RewardView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;
  Position? userLocation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
/*     ref.read(locationProvider.notifier).getCurrentLocation();
    ref.watch(locationProvider); */

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const HomeView(),
          const ProfilePage(),
          /* LocationPage(
            destination: LatLng(ref.read(locationProvider)!.latitude,
                ref.read(locationProvider)!.longitude),
          ), */
          SizedBox(),
          const RewardPage(),
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
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
