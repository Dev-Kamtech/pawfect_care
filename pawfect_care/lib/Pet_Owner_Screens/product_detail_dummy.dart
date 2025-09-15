import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pawfect_care/theme/theme.dart';

class ProductDetailDummyPage extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final String desc;

  const ProductDetailDummyPage({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Store"),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1.7,
              child: Image.network(
                image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: const Color(0xFFE0E0E0),
                    highlightColor: const Color(0xFFF5F5F5),
                    child: Container(color: const Color(0xFFE0E0E0)),
                  );
                },
                errorBuilder: (_, __, ___) => Container(color: const Color(0xFFEFF3F6)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(price, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Text(
            desc,
            style: const TextStyle(color: Colors.black87, height: 1.4),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: blueButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                "Buy Now",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
