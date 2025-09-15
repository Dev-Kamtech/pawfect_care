import 'package:flutter/material.dart';
import 'package:pawfect_care/Shelter_screens/appointments_shelter.dart';
import 'package:pawfect_care/Shelter_screens/home_shelter.dart';
import 'package:pawfect_care/Shelter_screens/requests_shelter.dart';
import 'package:pawfect_care/Shelter_screens/search_shelter.dart';
import 'package:pawfect_care/shared/public_profile_page.dart';
import 'package:pawfect_care/theme/theme.dart';
class ShelterRoot extends StatefulWidget {
  const ShelterRoot({super.key});

  @override
  State<ShelterRoot> createState() => _ShelterRootState();
}

class _ShelterRootState extends State<ShelterRoot> {
  int i = 0;

  final screens = const [
    ShelterHomeScreen(),
    ShelterSearchScreen(),
    ShelterAppointmentsScreen(),
    ShelterRequestsScreen(),
    PublicProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgColor,
      body: screens[i],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: whiteBgColor,
        currentIndex: i,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: blueButtonColor,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        onTap: (v) => setState(() => i = v),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Appointments"),
          BottomNavigationBarItem(icon: Icon(Icons.inbox), label: "Requests"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
