import 'package:app/ui/Location/location_ui.dart';
import 'package:app/ui/Profile/ProfileView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../ViewModels/userViewModel.dart';
import '../home_ui.dart';

class RewardPage extends ConsumerStatefulWidget {
  const RewardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RewardPageState();
}

class _RewardPageState extends ConsumerState<RewardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userDetails = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(255, 133, 74, 1),
                Color.fromRGBO(255, 62, 53, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: userDetails.when(
          data: (data) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Points',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Image.asset(
                              'assets/namecard.png',
                            ),
                          ),
                          Positioned(
                              top: 15,
                              left: 15,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    data.data()!['profilePictureUrl'] != null
                                        ? NetworkImage(
                                            data.data()!['profilePictureUrl'],
                                          )
                                        : const AssetImage(
                                            'assets/profile_pic_g.png',
                                          ) as ImageProvider,
                              )),
                          Positioned(
                            left: 105,
                            top: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data.data()!['firstName']} ${data.data()!['lastName']}",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'AVAILABLE POINTS',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "${data.data()!['_rewardPoints']}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: Image.asset(
                              'assets/point_history_btn.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Image.asset(
                              'assets/grey_rectangle.png',
                            ),
                          ),
                          const Positioned(
                            top: 0,
                            left: 20,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'How it works',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 90,
                            left: 25,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/orange_star.png',
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(width: 15),
                                const Text(
                                  'Image 1 Text',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 50,
                            left: 25,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/shopping_bag.png',
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(width: 15),
                                const Text(
                                  'Image 2 Text',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 25,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/crown.png',
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(width: 15),
                                const Text(
                                  'Image 3 Text',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Redeem your points',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Image.asset(
                              'assets/redeemPts1.png',
                            ),
                          ),
                          Positioned(
                            left: 17,
                            child: Image.asset(
                              'assets/redeemPts2.png',
                            ),
                          ),
                          Positioned(
                            left: 25,
                            child: Image.asset(
                              'assets/pizzaDragon.png',
                              width: 100,
                            ),
                          ),
                          const Positioned(
                            left: 180,
                            child: Text(
                              'Pizza Dragon',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Image.asset(
                              'assets/redeemPts1.png',
                            ),
                          ),
                          Positioned(
                            left: 17,
                            child: Image.asset(
                              'assets/redeemPts2.png',
                            ),
                          ),
                          Positioned(
                            top: .1,
                            left: 25,
                            child: Image.asset(
                              'assets/jakeu_cafe_logo.png',
                              width: 100,
                            ),
                          ),
                          const Positioned(
                            left: 185,
                            child: Text(
                              'Jakeu Cafe',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Image.asset(
                              'assets/redeemPts1.png',
                            ),
                          ),
                          Positioned(
                            left: 17,
                            child: Image.asset(
                              'assets/redeemPts2.png',
                            ),
                          ),
                          Positioned(
                            left: 25,
                            child: Image.asset(
                              'assets/master_buffalo_logo.png',
                              width: 100,
                            ),
                          ),
                          const Positioned(
                            left: 170,
                            child: Text(
                              'Master Buffalo',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          error: (error, stack) => Center(
                child: Text(error.toString()),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
