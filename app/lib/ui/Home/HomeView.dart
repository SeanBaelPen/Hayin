import 'package:app/ViewModels/foodStallViewModel.dart';
import 'package:app/ViewModels/userViewModel.dart';
import 'package:app/common/foodStall_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../ViewModels/filterViewModel.dart';
import '../../ViewModels/restaurantsViewModel.dart';
import '../../common/catalogue_format.dart';
import '../../common/restaurant_details.dart';
import '../../services/FirestoreService.dart';
import '../filter_ui.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    var restaurantsStream = ref.watch(streamProvider);
    var foodStallsStream = ref.watch(foodStallProvider);
    var userDetails = ref.watch(userProvider);
    Map<String, dynamic> filterTracker = ref.watch(filterProvider);

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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FilterPage(),
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
                  top: 120,
                  left: 0,
                  right: 0,
                  child: userDetails.when(data: (data) {
                    return Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: data.data()!['profilePictureUrl'] !=
                                null
                            ? NetworkImage(data.data()!['profilePictureUrl'])
                            : const AssetImage(
                                'assets/profile_pic_g.png',
                              ) as ImageProvider,
                      ),
                    );
                  }, error: (error, stack) {
                    return const Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(
                          'assets/profile_pic_g.png',
                        ),
                      ),
                    );
                  }, loading: () {
                    return const Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(
                          'assets/profile_pic_g.png',
                        ),
                      ),
                    );
                  }),
                ),
                Positioned(
                  top: 270,
                  left: 0,
                  right: 0,
                  child: userDetails.when(
                    data: (data) {
                      return Text(
                        data.data()!["firstName"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Sans Serif',
                          color: Colors.white,
                        ),
                      );
                    },
                    error: (error, stack) {
                      return const Text(
                        'Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Sans Serif',
                          color: Colors.white,
                        ),
                      );
                    },
                    loading: () {
                      return const Text(
                        'Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Sans Serif',
                          color: Colors.white,
                        ),
                      );
                    },
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
            ),
            const TabBar(
              tabs: [
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 13.0, left: 5, right: 5),
                child: TabBarView(
                  children: [
                    restaurantsStream.when(
                      data: (data) {
                        Iterable<MapEntry<String, dynamic>> booleanFilters =
                            filterTracker.entries
                                .where((entry) => entry.value is bool)
                                .map((entry) => entry);

                        List<dynamic> trueValues = booleanFilters
                            .where((entry) => entry.value == true)
                            .map((entry) => entry.key)
                            .toList();

                        print("ENABLED FILTERS: ${trueValues}");

                        var filteredData = data.docs.where((element) {
                          bool passesFilter = true;
                          for (int i = 0; i < trueValues.length; i++) {
                            print(element[trueValues[i]]);
                            if (element[trueValues[i]] != true) {
                              passesFilter = false;
                            }
                          }

                          print(
                              "${element.data()["minPrice"]} : ${filterTracker["minPrice"]}");

                          if (element.data()["minPrice"] <
                              filterTracker["minPrice"]) {
                            passesFilter = false;
                          }

                          print(
                              "${element.data()["maxPrice"]} : ${filterTracker["maxPrice"]}");

                          if (element.data()["maxPrice"] >
                              filterTracker["maxPrice"]) {
                            passesFilter = false;
                          }

                          return passesFilter;
                        }).toList();

                        var filteredPrice = data.docs.where((element) {
                          bool passesFilter = true;

                          print(
                              "${element.data()["minPrice"]} : ${filterTracker["minPrice"]}");

                          if (element.data()["minPrice"] <
                              filterTracker["minPrice"]) {
                            passesFilter = false;
                          }

                          print(
                              "${element.data()["maxPrice"]} : ${filterTracker["maxPrice"]}");

                          if (element.data()["maxPrice"] >
                              filterTracker["maxPrice"]) {
                            passesFilter = false;
                          }

                          return passesFilter;
                        }).toList();

                        return ListView.builder(
                          itemCount: trueValues.isEmpty
                              ? filteredPrice.length
                              : filteredData.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = trueValues.isEmpty
                                ? filteredPrice[index]
                                : filteredData[index];
                            return Catalogue(
                              image: document['image'],
                              name: document['name'],
                              categories: document['categories'],
                              onTap: () {
                                FirestoreService()
                                    .addRecentlyViewed(document.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RestaurantDetails(
                                      restaurantName: document['name'],
                                      restaurantImage: document['image'],
                                      restaurantID: document.id,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) =>
                          Center(child: Text('Error: $error')),
                    ),
                    foodStallsStream.when(
                      data: (data) {
                        Iterable<MapEntry<String, dynamic>> booleanFilters =
                            filterTracker.entries
                                .where((entry) => entry.value is bool)
                                .map((entry) => entry);

                        List<dynamic> trueValues = booleanFilters
                            .where((entry) => entry.value == true)
                            .map((entry) => entry.key)
                            .toList();

                        print("ENABLED FILTERS: ${trueValues}");

                        var filteredData = data.docs.where((element) {
                          bool passesFilter = true;
                          for (int i = 0; i < trueValues.length; i++) {
                            print(element[trueValues[i]]);
                            if (element[trueValues[i]] != true) {
                              passesFilter = false;
                            }
                          }

                          print(
                              "${element.data()["minPrice"]} : ${filterTracker["minPrice"]}");

                          if (element.data()["minPrice"] <
                              filterTracker["minPrice"]) {
                            passesFilter = false;
                          }

                          print(
                              "${element.data()["maxPrice"]} : ${filterTracker["maxPrice"]}");

                          if (element.data()["maxPrice"] >
                              filterTracker["maxPrice"]) {
                            passesFilter = false;
                          }

                          return passesFilter;
                        }).toList();

                        var filteredPrice = data.docs.where((element) {
                          bool passesFilter = true;

                          print(
                              "${element.data()["minPrice"]} : ${filterTracker["minPrice"]}");

                          if (element.data()["minPrice"] <
                              filterTracker["minPrice"]) {
                            passesFilter = false;
                          }

                          print(
                              "${element.data()["maxPrice"]} : ${filterTracker["maxPrice"]}");

                          if (element.data()["maxPrice"] >
                              filterTracker["maxPrice"]) {
                            passesFilter = false;
                          }

                          return passesFilter;
                        }).toList();

                        return ListView.builder(
                          itemCount: trueValues.isEmpty
                              ? filteredPrice.length
                              : filteredData.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = trueValues.isEmpty
                                ? filteredPrice[index]
                                : filteredData[index];
                            //List<dynamic> categories = document['categories'];
                            return Catalogue(
                              image: document['image'],
                              name: document['name'],
                              categories: document['categories'],
                              onTap: () {
                                FirestoreService()
                                    .addRecentlyViewed(document.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FoodStallDetails(
                                      restaurantName: document['name'],
                                      restaurantImage: document['image'],
                                      restaurantID: document.id,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) =>
                          Center(child: Text('Error: $error')),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
