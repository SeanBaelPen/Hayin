import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RestaurantDetails extends StatelessWidget {
  const RestaurantDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/Infinitea-Franchise.jpg',
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
