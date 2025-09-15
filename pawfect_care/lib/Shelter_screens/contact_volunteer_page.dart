import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pawfect_care/theme/theme.dart';

class ContactVolunteerPage extends StatelessWidget {
  const ContactVolunteerPage({super.key});

  InputDecoration d(String h) => InputDecoration(
    hintText: h, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    filled: true, fillColor: const Color(0xFFF6F8FA),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgColor,
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("Contact & Volunteer"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(decoration: d("Name")),
          const SizedBox(height: 10),
          TextField(decoration: d("Email")),
          const SizedBox(height: 10),
          TextField(maxLines: 5, decoration: d("Message")),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              "https://maps.googleapis.com/maps/api/staticmap?center=San+Francisco&zoom=12&size=800x400&key=AIzaSyB-demo", // dummy
              height: 180,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Shimmer.fromColors(
                  baseColor: const Color(0xFFE0E0E0),
                  highlightColor: const Color(0xFFF5F5F5),
                  child: Container(height: 180, color: const Color(0xFFE0E0E0)),
                );
              },
              errorBuilder: (_, __, ___) => Container(
                height: 180,
                color: const Color(0xFFEFF3F6),
                alignment: Alignment.center,
                child: const Text("Map Preview"),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(height: 52, child: ElevatedButton(onPressed: () {}, child: const Text("Volunteer Sign Up"))),
          const SizedBox(height: 10),
          SizedBox(height: 52, child: ElevatedButton(onPressed: () {}, child: const Text("Donate"))),
        ],
      ),
    );
  }
}
