import 'package:app/ui/Home/HomeView.dart';
import 'package:app/ui/Profile/ProfileView.dart';
import 'package:app/ui/Rewards/RewardView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../ViewModels/authViewModel.dart';
import 'Auth/welcome_ui.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authState = ref.watch(authStateProvider);
/*     ref.read(locationProvider.notifier).getCurrentLocation();
    ref.watch(locationProvider); */

    return Scaffold(
      body: authState.when(data: (data) {
        if (data?.uid == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WelcomePage()));
          });
        }
        return IndexedStack(
          index: _selectedIndex,
          children: const [
            HomeView(),
            ProfilePage(),
            /* LocationPage(
            destination: LatLng(ref.read(locationProvider)!.latitude,
                ref.read(locationProvider)!.longitude),
          ), */
            SizedBox(),
            RewardPage(),
          ],
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
