import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RestaurantDetails extends StatelessWidget {
  const RestaurantDetails({required this.image, super.key});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: SvgPicture.asset('assets/icons/back.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
