import 'package:flutter/material.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({Key? key}) : super(key: key);

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
                SizedBox(height: 10),
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Image.asset(
                          'assets/namecard.png',
                        ),
                      ),
                      Positioned(
                        top: 15,
                        left: 15,
                        child: Image.asset(
                          'assets/profile_pic_g.png',
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const Positioned(
                        left: 105,
                        top: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'AVAILABLE POINTS',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              '1040',
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
                SizedBox(height: 25),
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
                        left: 20,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/shopping_bag.png',
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
                        left: 20,
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
                        left: 20,
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
