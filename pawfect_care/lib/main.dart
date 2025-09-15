import 'package:flutter/material.dart';
import 'package:pawfect_care/Authentication/login_page.dart';
import 'package:pawfect_care/Authentication/reset_password_email_page.dart';
import 'package:pawfect_care/Authentication/reset_password_page.dart';
import 'package:pawfect_care/Authentication/signup_page.dart';
import 'package:pawfect_care/Authentication/role_selection_page.dart';
import 'package:pawfect_care/Pet_Owner_Screens/pet_owner_dashboard.dart';
import 'package:pawfect_care/Shelter_screens/shelter_dashboard.dart';
import 'package:pawfect_care/Vet_screens/vet_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/signup',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/forgot': (context) => const ResetPasswordEmailPage(),
        '/reset': (context) => const ResetPasswordPage(),
        '/role': (context) => const RoleSelectionPage(),
        '/owner': (context) => const PetOwnerDashboard(),
        '/vet': (context) => const VetMain(),
        '/shelter': (context) => const ShelterRoot(),
      },
    );
  }
}
