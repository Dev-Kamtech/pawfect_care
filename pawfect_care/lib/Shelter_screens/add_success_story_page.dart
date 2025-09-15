import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';

class AddSuccessStoryPage extends StatelessWidget {
  const AddSuccessStoryPage({super.key});

  InputDecoration d(String h) => InputDecoration(
    hintText: h,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
        title: const Text("Add Success Story"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Pet Name"), const SizedBox(height: 6),
          TextField(decoration: d("Enter pet name")),
          const SizedBox(height: 12),
          const Text("Adopter Name"), const SizedBox(height: 6),
          TextField(decoration: d("Enter adopter name")),
          const SizedBox(height: 12),
          const Text("Story"), const SizedBox(height: 6),
          TextField(maxLines: 6, decoration: d("Share the heartwarming tale...")),
          const SizedBox(height: 16),
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFD7DDE6), style: BorderStyle.solid),
            ),
            child: const Center(child: Text("Upload Photo")),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: blueButtonColor, foregroundColor: Colors.white),
              child: const Text("Submit Story"),
            ),
          ),
      ],
      ),
    );
  }
}
