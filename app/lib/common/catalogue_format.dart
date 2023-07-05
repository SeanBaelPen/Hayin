import 'package:flutter/material.dart';

class Catalogue extends StatelessWidget {
  Catalogue({
    Key? key,
    required this.image,
    required this.name,
    required this.categories,
    required this.onTap,
  }) : super(key: key);

  final String image;
  final String name;
  final List<dynamic> categories;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 250,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, top: 5, left: 10),
          child: Container(
            //padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 145,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: categories.map((category) {
                                final String label = category is String
                                    ? category
                                    : category.toString();
                                return Chip(
                                  label: Text(label),
                                  backgroundColor: Colors.grey,
                                );
                              }).toList(),
                            )
                            // Text(
                            //   text2,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
