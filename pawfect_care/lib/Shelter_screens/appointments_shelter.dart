import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';

class ShelterAppointmentsScreen extends StatelessWidget {
  const ShelterAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgColor,
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Appointments"),
        centerTitle: true,
      ),
      body: const Center(child: Text("Appointments (dummy)")),
    );
  }
}
