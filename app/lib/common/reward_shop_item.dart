import 'package:flutter/material.dart';

class RewardShopItem extends StatelessWidget {
  final String imagePath;
  final String shopName;
  final VoidCallback onTap;

  const RewardShopItem({
    required this.imagePath,
    required this.shopName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.network(
                imagePath,
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              shopName,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
