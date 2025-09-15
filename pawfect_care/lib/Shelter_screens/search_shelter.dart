import 'package:flutter/material.dart';
import 'adoptable_pets_page.dart';
import 'package:pawfect_care/theme/theme.dart';

class ShelterSearchScreen extends StatelessWidget {
  const ShelterSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgColor,
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Search"),
      ),
      body: Center(
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: blueButtonColor, foregroundColor: Colors.white),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdoptablePetsPage())),
            child: const Text("Browse Adoptable Pets"),
          ),
        ),
      ),
    );
  }
}
