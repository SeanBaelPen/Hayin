import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int _currentIndex =
      0; // Current index of the selected item in the bottom navigation bar
  int _selectedImageIndex = 0; // Index of the selected image
  //var selectedRange = RangeValues(100, 300, 500, 1000);
  RangeValues selectedRange = const RangeValues(100, 300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 10),
              child: Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.clear_sharp,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          'Clear all',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedImageIndex = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedImageIndex == 0
                              ? Colors.orange
                              : const Color.fromARGB(255, 182, 180, 180),
                          // Change color to orange when selected
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Image.asset('assets/drinks.png'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Drinks'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedImageIndex = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedImageIndex == 1
                              ? Colors.orange
                              : const Color.fromARGB(255, 182, 180, 180),
                          // Change color to orange when selected
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Image.asset('assets/desserts.png'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Desserts'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedImageIndex = 2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedImageIndex == 2
                              ? Colors.orange
                              : const Color.fromARGB(255, 182, 180, 180),
                          // Change color to orange when selected
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Image.asset('assets/meal.png'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Meal'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
              height: 20), // space between the row of images and the text
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ),
          ),
          SizedBox(height: 10), // space between the text and buttons
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120, // Set the desired width for the buttons
                    padding: EdgeInsets.all(
                        8), // Set the desired padding around the button and text
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Add button 1 onPressed logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded borders
                        ),
                      ),
                      child: Text('Near Me'),
                    ),
                  ),
                  Container(
                    width: 120, // Set the desired width for the buttons
                    padding: EdgeInsets.all(
                        8), // Set the desired padding around the button and text
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Add PUP btn onPressed logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded borders
                        ),
                      ),
                      child: Text('PUP'),
                    ),
                  ),
                  Container(
                    width: 120, // Set the desired width for the buttons
                    padding: EdgeInsets.all(
                        8), // Set the desired padding around the button and text
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Add Sta. Mesa St. onPressed logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded borders
                        ),
                      ),
                      child: Text(
                        'Sta. Mesa St.',
                        textAlign: TextAlign.center, // Align text at the center
                      ),
                    ),
                  ),
                ],
              ),
              //SizedBox(height: 10), // space between the rows of buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120, // Set the desired width for the buttons
                    padding: EdgeInsets.all(
                        8), // Set the desired padding around the button and text
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Add button 1 onPressed logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded borders
                        ),
                      ),
                      child: Text('Near Me'),
                    ),
                  ),
                  Container(
                    width: 120, // Set the desired width for the buttons
                    padding: EdgeInsets.all(
                        8), // Set the desired padding around the button and text
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Add PUP btn onPressed logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded borders
                        ),
                      ),
                      child: Text('PUP'),
                    ),
                  ),
                  Container(
                    width: 120, // Set the desired width for the buttons
                    padding: EdgeInsets.all(
                        8), // Set the desired padding around the button and text
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Add Sta. Mesa St. onPressed logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded borders
                        ),
                      ),
                      child: Text(
                        'Sta. Mesa St.',
                        textAlign: TextAlign.center, // Align text at the center
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
              height: 20), // space between the row of images and the text
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Filter by',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ),
          ),
          SizedBox(height: 10), // space between the text and buttons
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120, // Set the desired width for the buttons
                    padding: EdgeInsets.all(
                        8), // Set the desired padding around the button and text
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Add Open btn onPressed logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded borders
                        ),
                      ),
                      child: Text('Open'),
                    ),
                  ),
                  Container(
                    width: 120, // Set the desired width for the buttons
                    padding: EdgeInsets.all(
                        8), // Set the desired padding around the button and text
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Add Preferred btn onPressed logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded borders
                        ),
                      ),
                      child: Text('Preferred'),
                    ),
                  ),
                  Container(
                    width: 120, // Set the desired width for the buttons
                    padding: EdgeInsets.all(
                        8), // Set the desired padding around the button and text
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Add Sale btn onPressed logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded borders
                        ),
                      ),
                      child: Text('Sale'),
                    ),
                  ),
                ],
              ),
              //SizedBox(height: 10), // space between the rows of buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Add button 4 onPressed logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded borders
                      ),
                    ),
                    child: Text('Button 4'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Add button 5 onPressed logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded borders
                      ),
                    ),
                    child: Text('Button 5'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Add button 6 onPressed logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded borders
                      ),
                    ),
                    child: Text('Button 6'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
              height:
                  20), // space between the filter buttons and the RangeSlider
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Price',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  RangeSlider(
                    values: selectedRange,
                    min: 0,
                    max: 1000,
                    divisions: 3,
                    onChanged: (RangeValues values) {
                      setState(() {
                        selectedRange = values;
                      });
                    },
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0'),
                        Text('125'),
                        Text('250'),
                        Text('1000'),
                        //Text('500'),
                      ],
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 10),
              // Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     Positioned(
              //     top: 500,
              //     InkWell(
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (BuildContext context) {
              //             return const FilterPage();
              //           }),
              //         );
              //         print('Login button tapped');
              //       },
              //       child: Image.asset(
              //         'assets/applyBtn.jpg',
              //         width: 70,
              //         height: 70,
              //       ),
              //     ),
              //     ),
              //   ],
              // ),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:
            Colors.orange, // Set the selected item color to orange
        unselectedItemColor:
            Colors.grey, // Set the unselected item color to grey
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_sharp,
              size: 50,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 50,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on,
              size: 50,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              size: 50,
            ),
            label: '',
          ),
        ],
        type: BottomNavigationBarType
            .fixed, // make the icons stay in place when you tap on them
      ),
    );
  }
}
