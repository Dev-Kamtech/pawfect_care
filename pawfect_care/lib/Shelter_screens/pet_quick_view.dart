import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class PetQuickView extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String subtitle;

  const PetQuickView({super.key, required this.name, required this.imageUrl, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgColor,
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1.6,
              child: Image.network(
                imageUrl,
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
          Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 14),
          const Text("Short description goes here.", style: TextStyle(height: 1.4)),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(onPressed: () {}, child: const Text("Contact Shelter")),
          ),
        ],
      ),
    );
  }
}
