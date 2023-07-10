import 'package:app/common/ratingDialog.dart';
import 'package:app/models/review_model..dart';
import 'package:app/services/FirestoreService.dart';
import 'package:app/ui/Location/location_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

import '../../ViewModels/menuViewModel.dart';
import '../../ViewModels/ratingsViewModel.dart';
import '../ViewModels/userViewModel.dart';
import 'menu_card.dart';
import '../../models/menu_model.dart';

class FoodStallDetails extends ConsumerStatefulWidget {
  final String restaurantName;
  final String restaurantImage;
  final String restaurantID;
  const FoodStallDetails({
    super.key,
    required this.restaurantName,
    required this.restaurantImage,
    required this.restaurantID,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FoodStallDetailsState();
}

class _FoodStallDetailsState extends ConsumerState<FoodStallDetails> {
  double? destinationLatitude;
  double? destinationLongitude;
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    fetchDestinationCoordinates();
  }

  Future<void> fetchDestinationCoordinates() async {
    DocumentSnapshot restaurantSnapshot = await FirebaseFirestore.instance
        .collection('foodStalls')
        .doc(widget.restaurantID)
        .get();

    if (restaurantSnapshot.exists) {
      GeoPoint destinationLocation = restaurantSnapshot['destinationLocation'];
      List<dynamic> categoryList = restaurantSnapshot['categories'];
      List<String> restaurantCategories = categoryList.cast<String>().toList();
      setState(() {
        destinationLatitude = destinationLocation.latitude;
        destinationLongitude = destinationLocation.longitude;
        categories = restaurantCategories;
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
    var menuDetails = ref.watch(menuProvider);
    var ratingDetails = ref.watch(ratingsProvider);
    var userDetails = ref.watch(userProvider);
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
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
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: categories.map((category) {
                            return Chip(
                              label: Text(category),
                            );
                          }).toList(),
                        ),
                        const Text('200+ ratings'),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: navigateToLocationPage,
                              child: const Text('Get Location'),
                            ),
                            userDetails.when(
                              data: (data) {
                                return IconButton(
                                  onPressed: () {
                                    if (data
                                        .data()!["favorites"]
                                        .contains(widget.restaurantID)) {
                                      FirestoreService()
                                          .removeFavorite(widget.restaurantID);
                                    } else {
                                      FirestoreService()
                                          .addFavorite(widget.restaurantID);
                                    }
                                  },
                                  color: data
                                          .data()!["favorites"]
                                          .contains(widget.restaurantID)
                                      ? Colors.red
                                      : Colors.black,
                                  icon: Icon(
                                    data
                                            .data()!["favorites"]
                                            .contains(widget.restaurantID)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                  ),
                                );
                              },
                              error: (error, stack) {
                                return Text(error.toString());
                              },
                              loading: () {
                                return const CircularProgressIndicator();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                minHeight: 90,
                maxHeight: 90,
                child: const TabBar(
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
              )),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TabBarView(
              children: [
                menuDetails.when(
                  data: (data) {
                    var filteredMenu = data.docs.where((element) {
                      return element['restaurantId'] == widget.restaurantID;
                    }).toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredMenu.length,
                      itemBuilder: (context, index) {
                        MenuItemModel item =
                            MenuItemModel.fromMap(filteredMenu[index].data());
                        return MenuCard(
                          item: item,
                        );
                      },
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
                ),
                ratingDetails.when(data: (data) {
                  var filteredReview = data.docs.where((element) {
                    return element['restaurantId'] == widget.restaurantID;
                  }).toList();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reviews',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredReview.length,
                          padding: const EdgeInsets.only(top: 0),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            ReviewModel review = ReviewModel.fromMap(
                                filteredReview[index].data());
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(review.userImg),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    review.userName,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  RatingBar.builder(
                                    initialRating: review.rating,
                                    minRating: 1,
                                    itemSize: 22,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                review.review,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (builder) {
                                  return RatingDialog(
                                    restaurantId: widget.restaurantID,
                                  );
                                });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 10,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child:
                              Text('Add Review', style: GoogleFonts.poppins()),
                        ),
                      )
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
              ],
            ),
          )),
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
