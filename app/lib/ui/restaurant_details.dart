import 'package:app/ui/location_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../MenuCards/menu_card.dart';
import '../MenuModel/menu_model.dart';

class RestaurantDetails extends StatefulWidget {
  const RestaurantDetails({super.key});

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  double? destinationLatitude;
  double? destinationLongitude;

  @override
  void initState() {
    super.initState();
    fetchDestinationCoordinates();
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
                'https://lh5.googleusercontent.com/p/AF1QipPLJnOGebslG5wusfjMptBtOpHdXKfujqUtJJ9K=w284-h160-k-no',
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pizza Dragon',
                    style: TextStyle(
                        fontSize: 27,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '100-200 · Desserts, Drinks, Pastries',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  Text('200+ ratings'),
                  ElevatedButton(
                    onPressed: navigateToLocationPage,
                    child: Text('Get Location'),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: pizzaDragonMenu.length,
              itemBuilder: (context, index) {
                PizzaDragon pizza = pizzaDragonMenu[index];
                return MenuCard(pizza: pizza);
              },
            ),
          )
        ],
      ),
    );
  }
}
