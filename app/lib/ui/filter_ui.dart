import 'package:app/ui/home_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ViewModels/filterViewModel.dart';

class FilterPage extends ConsumerStatefulWidget {
  const FilterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterPageState();
}

class _FilterPageState extends ConsumerState<FilterPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> filterTracker = ref.watch(filterProvider);
    //filterTracker = ref.watch(filterProvider.notifier).state;
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.clear_sharp,
                      size: 50,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (builder) => HomePage()));
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text(
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
                        margin: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            ref.read(filterProvider.notifier).clearFilter();
                            setState(() {});
                          },
                          child: const Text(
                            'Clear all',
                            style: TextStyle(
                              fontSize: 18,
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
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        ref
                            .read(filterProvider.notifier)
                            .changeFilter('drinks', !filterTracker["drinks"]);
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: filterTracker["drinks"] == true
                              ? const Color.fromARGB(255, 248, 102, 49)
                              : const Color.fromARGB(255, 218, 214, 214),
                          // Change color to orange when selected
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Image.asset('assets/drinks.png'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Drinks'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        ref.read(filterProvider.notifier).changeFilter(
                            'desserts', !filterTracker["desserts"]);
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: filterTracker['desserts'] == true
                              ? const Color.fromARGB(255, 248, 102, 49)
                              : const Color.fromARGB(255, 218, 214, 214),
                          // Change color to orange when selected
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Image.asset('assets/desserts.png'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Desserts'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        ref
                            .read(filterProvider.notifier)
                            .changeFilter('meal', !filterTracker["meal"]);
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: filterTracker['meal'] == true
                              ? const Color.fromARGB(255, 248, 102, 49)
                              : const Color.fromARGB(255, 218, 214, 214),
                          // Change color to orange when selected
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Image.asset('assets/meal.png'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Meal'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
              height: 50), // space between the row of images and the text
          const Padding(
            padding: EdgeInsets.only(left: 15),
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
          const SizedBox(height: 10), // space between the text and buttons
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(filterProvider.notifier)
                          .changeFilter('open', !filterTracker['open']);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: filterTracker['open'] == true
                          ? const Color.fromARGB(255, 248, 102, 49)
                          : const Color.fromARGB(255, 218, 214, 214),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Halal',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(filterProvider.notifier).changeFilter(
                          'preferred', !filterTracker['preferred']);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: filterTracker['preferred'] == true
                          ? const Color.fromARGB(255, 248, 102, 49)
                          : const Color.fromARGB(255, 218, 214, 214),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Preferred',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5), // space between the buttons
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(filterProvider.notifier)
                          .changeFilter('sale', !filterTracker['sale']);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: filterTracker['sale'] == true
                          ? const Color.fromARGB(255, 248, 102, 49)
                          : const Color.fromARGB(255, 218, 214, 214),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Promo',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
              height:
                  50), // space between the filter buttons and the RangeSlider
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15),
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
                    values: RangeValues(
                      filterTracker['minPrice'],
                      filterTracker['maxPrice'],
                    ),
                    min: 0,
                    max: 500, // Set the maximum value to 500
                    divisions: 2, // Set the number of divisions to 2
                    onChanged: (RangeValues values) {
                      ref
                          .read(filterProvider.notifier)
                          .changeFilter("minPrice", values.start);
                      ref
                          .read(filterProvider.notifier)
                          .changeFilter("maxPrice", values.end);
                      setState(() {});
                    },
                    activeColor: const Color.fromARGB(
                        255, 248, 102, 49), // Set the active color to orange
                  ),
                  const SizedBox(height: 60),
                  const Positioned(
                    left: 20,
                    right: 20,
                    bottom: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('- ₱100'),
                        Text(
                            '₱250'), // Adjusted to the new maximum value of 500
                        Text('₱500 +'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => HomePage()));
                      },
                      child: Image.asset(
                        'assets/applyBtn.jpg',
                        width: 350,
                        height: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: const Color.fromARGB(
      //       255, 248, 102, 49), // Set the selected item color to orange
      //   unselectedItemColor:
      //       Colors.grey, // Set the unselected item color to grey
      //   currentIndex: _currentIndex,
      //   onTap: (int index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home_sharp,
      //         size: 50,
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.search,
      //         size: 50,
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.location_on,
      //         size: 50,
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.account_circle_outlined,
      //         size: 50,
      //       ),
      //       label: '',
      //     ),
      //   ],
      //   type: BottomNavigationBarType
      //       .fixed, // make the icons stay in place when you tap on them
      // ),
    );
  }
}
