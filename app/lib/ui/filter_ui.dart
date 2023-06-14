import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int _currentIndex =
      0; // Current index of the selected item in the bottom navigation bar

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
                      fontSize: 25,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Other Content',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
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
