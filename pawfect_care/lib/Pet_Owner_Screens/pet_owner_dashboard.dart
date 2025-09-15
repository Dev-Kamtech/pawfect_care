import 'package:flutter/material.dart';
import 'package:pawfect_care/Pet_Owner_Screens/appointments_screen.dart';
import 'package:pawfect_care/Pet_Owner_Screens/pet_home_screen.dart';
import 'package:pawfect_care/Pet_Owner_Screens/pets_screen.dart';
import 'package:pawfect_care/Pet_Owner_Screens/profile_screen.dart';
import 'package:pawfect_care/Pet_Owner_Screens/store_screen.dart';
import 'package:pawfect_care/shared/public_profile_page.dart';
import 'package:pawfect_care/theme/theme.dart';

class PetOwnerDashboard extends StatefulWidget {
  const PetOwnerDashboard({super.key});

  @override
  State<PetOwnerDashboard> createState() => _PetOwnerDashboardState();
}

class _PetOwnerDashboardState extends State<PetOwnerDashboard> {
  int _selectedIndex = 0;

  static const _screens = [
    HomeScreen(),
    PetsScreen(),
    AppointmentsScreen(),
    StoreScreen(),
    PublicProfilePage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: _screens[_selectedIndex],
    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: whiteBgColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: blueButtonColor,
      unselectedItemColor: Colors.blueGrey,
      showUnselectedLabels: true,
      onTap: (i) => setState(() => _selectedIndex = i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Pets"),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: "Appointments",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.storefront), label: "Store"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    ),
  );
}
