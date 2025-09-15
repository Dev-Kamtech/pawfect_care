import 'package:flutter/material.dart';
import 'package:pawfect_care/shared/public_profile_page.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:pawfect_care/Vet_screens/vet_dashboard_page.dart';
import 'package:pawfect_care/Vet_screens/vet_messages_page.dart';
import 'package:pawfect_care/Vet_screens/vet_pets_page.dart';

class VetMain extends StatefulWidget {
  const VetMain({super.key});

  @override
  State<VetMain> createState() => _VetMainState();
}

class _VetMainState extends State<VetMain> {
  int i = 0;
  final pages = const [
    VetDashboardPage(),
    VetPetsPage(),
    VetMessagesPage(),
    PublicProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgColor,
      body: pages[i],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: whiteBgColor,
        currentIndex: i,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: blueButtonColor,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        onTap: (v) => setState(() => i = v),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Pets"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
