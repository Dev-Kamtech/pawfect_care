// lib/widgets/pet_card.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pawfect_care/Pet_Owner_Screens/pet_detail_page.dart';

class PetCard extends StatelessWidget {
  final int petId; // <-- add this
  final String name;
  final int years;
  final String breed;
  final String imagePath;

  const PetCard({
    super.key,
    required this.petId, // <-- add this
    required this.name,
    required this.years,
    required this.breed,
    required this.imagePath,
  });

  bool get _isFile =>
      imagePath.startsWith('/') || imagePath.startsWith('file:');

  @override
  Widget build(BuildContext context) {
    Widget img = _isFile
        ? Image.file(
            File(imagePath),
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Image.asset(
              'assets/icon-1.png',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          )
        : Image.asset(
            imagePath.isEmpty ? 'assets/icon-1.png' : imagePath,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PetDetailsPage(
              petId: petId, // <-- pass it
              name: name,
              years: years,
              breed: breed,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(12), child: img),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$years years old",
                  style: const TextStyle(color: Colors.black54),
                ),
                Text(breed, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
