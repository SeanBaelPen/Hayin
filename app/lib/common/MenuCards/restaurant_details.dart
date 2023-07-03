import 'package:app/ui/Location/location_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'menu_card.dart';
import '../../models/menu_model.dart';

class RestaurantDetails extends StatefulWidget {
  final String restaurantName;
  final String restaurantImage;

  const RestaurantDetails({
    super.key,
    required this.restaurantName,
    required this.restaurantImage,
  });

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails>
    with SingleTickerProviderStateMixin {
  double? destinationLatitude;
  double? destinationLongitude;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    TabController _tabController = TabController(length: 2, vsync: this);
    fetchDestinationCoordinates();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchDestinationCoordinates() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('restaurants')
        .doc('RyLBEVoG3jjegqxfSqXY')
        .get();

    if (snapshot.exists) {
      GeoPoint destinationLocation = snapshot['destinationLocation'];
      setState(() {
        destinationLatitude = destinationLocation.latitude;
        destinationLongitude = destinationLocation.longitude;
      });
    }
  }

  void navigateToLocationPage() {
    if (destinationLatitude != null && destinationLongitude != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationPage(
            destination: LatLng(destinationLatitude!, destinationLongitude!),
          ),
        ),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.restaurantImage,
                fit: BoxFit.cover,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DefaultTabController(
              length: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurantName,
                      style: const TextStyle(
                          fontSize: 27,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      '100-200 · Desserts, Drinks, Pastries',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const Text('200+ ratings'),
                    ElevatedButton(
                      onPressed: navigateToLocationPage,
                      child: const Text('Get Location'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      text: 'Menu',
                    ),
                    Tab(
                      text: 'Reviews',
                    ),
                  ],
                ),
                TabBarView(children: [
                  SliverToBoxAdapter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: pizzaDragonMenu.length,
                      itemBuilder: (context, index) {
                        PizzaDragon pizza = pizzaDragonMenu[index];
                        return MenuCard(pizza: pizza);
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Text("Reviews"),
                    ),
                  )
                ]),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
