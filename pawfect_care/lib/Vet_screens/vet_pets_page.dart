import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class VetPetsPage extends StatelessWidget {
  const VetPetsPage({super.key});

  Widget pet(String img, String name, String sub) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 6)],
      ),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox(
              width: 56,
              height: 56,
              child: Image.network(
                img,
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
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
            Text(sub, style: const TextStyle(color: Colors.blueGrey)),
          ])),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgColor,
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Pets"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          pet("https://images.unsplash.com/photo-1543466835-00a7907e9de1", "Buddy", "Dog, 3 years"),
          pet("https://images.unsplash.com/photo-1519052534-7a3c43aabd0c", "Whiskers", "Cat, 5 years"),
          pet("https://images.unsplash.com/photo-1552053831-71594a27632d", "Charlie", "Beagle, 2 years"),
        ],
      ),
    );
  }
}
