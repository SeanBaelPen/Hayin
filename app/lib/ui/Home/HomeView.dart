import 'package:app/ViewModels/foodStallViewModel.dart';
import 'package:app/ViewModels/userViewModel.dart';
import 'package:app/ui/Auth/welcome_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ViewModels/authViewModel.dart';
import '../../ViewModels/restaurantsViewModel.dart';
import '../../common/catalogue_format.dart';
import '../../common/restaurant_details.dart';
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
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
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
                        return ListView.builder(
                          itemCount: data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = data.docs[index];
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
                                      restaurantID: document.id,
                                    ), // Replace NewPage with your desired page
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
                        return ListView.builder(
                          itemCount: data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot document = data.docs[index];
                            //List<dynamic> categories = document['categories'];
                            return Catalogue(
                              image: document['image'],
                              name: document['name'],
                              categories: [],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RestaurantDetails(
                                      restaurantName: document['name'],
                                      restaurantImage: document['image'],
                                      restaurantID: document.id,
                                    ), // Replace NewPage with your desired page
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
