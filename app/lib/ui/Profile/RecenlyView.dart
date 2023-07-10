import 'package:app/common/foodStall_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../ViewModels/userViewModel.dart';
import '../../common/catalogue_format.dart';
import '../../common/restaurant_details.dart';


class RecentlyView extends ConsumerStatefulWidget {
  const RecentlyView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecentlyViewState();
}

class _RecentlyViewState extends ConsumerState<RecentlyView> {
  @override
  Widget build(BuildContext context) {
    var userDetails = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Recently Viewed'),
      ),
      body: userDetails.when(
        data: (data) {
          var recentlyList = data.data()?["recentlyViewed"] ?? [];

          return ListView.builder(
            itemCount: recentlyList.length,
            itemBuilder: (context, index) {
              final restaurantFuture = FirebaseFirestore.instance
                  .collection('restaurants')
                  .doc(recentlyList[index])
                  .get();
              final foodStallFuture = FirebaseFirestore.instance
                  .collection('foodStalls')
                  .doc(recentlyList[index])
                  .get();
              return FutureBuilder(
                future: Future.wait([restaurantFuture, foodStallFuture]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading...');
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final restaurantSnapshot = snapshot.data![0];
                    final foodStallSnapshot = snapshot.data![1];

                    final restaurantData = restaurantSnapshot.data();
                    final foodStallData = foodStallSnapshot.data();

                    Widget? catalogueWidget;

                    if (restaurantData != null) {
                      catalogueWidget = Catalogue(
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
                      catalogueWidget = Catalogue(
                        image: foodStallData['image'],
                        name: foodStallData['name'],
                        categories: foodStallData['categories'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodStallDetails(
                                restaurantName: foodStallData['name'],
                                restaurantImage: foodStallData['image'],
                                restaurantID: foodStallSnapshot.id,
                              ),
                            ),
                          );
                        },
                      );
                    } else if (!snapshot.hasData) {
                      catalogueWidget = Container();
                    }
                    return catalogueWidget ?? Container();
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
