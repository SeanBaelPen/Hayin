import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45, left: 25),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    IconButton(
                      iconSize: 35,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Handle button press here
                        Navigator.pop(context); // Navigates back when pressed
                      },
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 60, top: 25),
                    child: Image.asset(
                      'assets/icon_user_black.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(width: 35),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'hello@gmail.com',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      child: Image.asset(
                        'assets/rectangle_settings.png',
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 30,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/logout.png',
                          ),
                          const SizedBox(width: 25),
                          const Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 80,
                      left: 10,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: PhysicalModel(
                          elevation: 4,
                          shadowColor: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Handle button tap here
                            },
                            child: Container(
                              width: double
                                  .infinity, // Stretch the button to fit the width
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Row(
                                children: [
                                  Text(
                                    'Notifications',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 110),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Positioned(
                      top: 130,
                      left: 10,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: PhysicalModel(
                          elevation: 4,
                          shadowColor: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Handle button tap here
                            },
                            child: Container(
                              width: double
                                  .infinity, // Stretch the button to fit the width
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Row(
                                children: [
                                  Text(
                                    'Language',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 140),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Positioned(
                      top: 180,
                      left: 10,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: PhysicalModel(
                          elevation: 4,
                          shadowColor: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Handle button tap here
                            },
                            child: Container(
                              width: double
                                  .infinity, // Stretch the button to fit the width
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Row(
                                children: [
                                  Text(
                                    'Help and Support',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 70),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
