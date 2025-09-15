import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';

class AddPetListingPage extends StatelessWidget {
  const AddPetListingPage({super.key});

  InputDecoration deco(String h) => InputDecoration(
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
        title: const Text("Add Pet Listing"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Pet Name"), const SizedBox(height: 6),
          TextField(decoration: deco("Enter pet's name")),
          const SizedBox(height: 12),
          const Text("Type"), const SizedBox(height: 6),
          DropdownButtonFormField(items: const [
            DropdownMenuItem(value: "Dog", child: Text("Dog")),
            DropdownMenuItem(value: "Cat", child: Text("Cat")),
          ], onChanged: (v){}, decoration: deco("Select pet type")),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Age"), const SizedBox(height: 6),
              TextField(decoration: deco("e.g., 2 years")),
            ])),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Gender"), const SizedBox(height: 6),
              DropdownButtonFormField(items: const [
                DropdownMenuItem(value: "Male", child: Text("Male")),
                DropdownMenuItem(value: "Female", child: Text("Female")),
              ], onChanged: (v){}, decoration: deco("Select gender")),
            ])),
          ]),
          const SizedBox(height: 12),
          const Text("Health Status"), const SizedBox(height: 6),
          DropdownButtonFormField(items: const [
            DropdownMenuItem(value: "Healthy", child: Text("Healthy")),
            DropdownMenuItem(value: "Needs Care", child: Text("Needs Care")),
          ], onChanged: (v){}, decoration: deco("Select health status")),
          const SizedBox(height: 12),
          const Text("Adoption Status"), const SizedBox(height: 6),
          DropdownButtonFormField(items: const [
            DropdownMenuItem(value: "Available", child: Text("Available")),
            DropdownMenuItem(value: "Pending", child: Text("Pending")),
            DropdownMenuItem(value: "Adopted", child: Text("Adopted")),
          ], onChanged: (v){}, decoration: deco("Select adoption status")),
          const SizedBox(height: 16),
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFFF6FBFF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFD6E6F5), style: BorderStyle.solid),
            ),
            child: const Center(child: Text("Upload Photo")),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: blueButtonColor, foregroundColor: Colors.white),
              child: const Text("Save Listing"),
            ),
          ),
        ],
      ),
    );
  }
}
