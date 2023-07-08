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
          var recentlyList = data.data()!["recentlyViewed"];

          return ListView.builder(
            itemCount: recentlyList.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('restaurants')
                      .doc(recentlyList[index])
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Catalogue(
                        image: snapshot.data!['image'],
                        name: snapshot.data!['name'],
                        categories: snapshot.data!['categories'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantDetails(
                                restaurantName: snapshot.data!['name'],
                                restaurantImage: snapshot.data!['image'],
                                restaurantID: snapshot.data!.id,
                              ), // Replace NewPage with your desired page
                            ),
                          );
                        },
                      );
                    } else {
                      return Text('Loading...');
                    }
                  });
            },
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}
