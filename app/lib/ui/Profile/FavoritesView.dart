import 'dart:math';

import 'package:app/common/catalogue_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ViewModels/userViewModel.dart';
import '../../common/restaurant_details.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    var userDetails = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: userDetails.when(
        data: (data) {
          var recentlyList = data.data()!["favorites"];
          print("LIST: ${recentlyList}");
          return ListView.builder(
            itemCount: recentlyList.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                future: Future.wait([
                  FirebaseFirestore.instance
                      .collection('restaurants')
                      .doc(recentlyList[index])
                      .get(),
                  FirebaseFirestore.instance
                      .collection('foodStalls')
                      .doc(recentlyList[index])
                      .get(),
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading...');
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final restaurantSnapshot =
                        snapshot.data![0] as DocumentSnapshot;
                    final foodStallSnapshot =
                        snapshot.data![1] as DocumentSnapshot;

                    final restaurantData =
                        restaurantSnapshot.data() as Map<String, dynamic>?;
                    final foodStallData =
                        foodStallSnapshot.data() as Map<String, dynamic>?;

                    if (restaurantData != null) {
                      return Catalogue(
                        image: restaurantData['image'],
                        name: restaurantData['name'],
                        categories: restaurantData['categories'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantDetails(
                                restaurantName: restaurantData['name'],
                                restaurantImage: restaurantData['image'],
                                restaurantID: restaurantSnapshot.id,
                              ),
                            ),
                          );
                        },
                      );
                    } else if (foodStallData != null) {
                      return Catalogue(
                        image: foodStallData['image'],
                        name: foodStallData['name'],
                        categories: foodStallData['categories'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantDetails(
                                restaurantName: foodStallData['name'],
                                restaurantImage: foodStallData['image'],
                                restaurantID: foodStallSnapshot.id,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
                  return Text('Loading...');
                },
              );
            },
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}
