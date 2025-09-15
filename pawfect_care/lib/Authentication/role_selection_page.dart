import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:pawfect_care/widgets/role_card.dart';
import 'package:pawfect_care/session.dart';
import 'package:pawfect_care/db_helper.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  Future<void> _pick(BuildContext context, String role) async {
    if (Session.currentUserId != null) {
      await DBHelper.updateRole(Session.currentUserId!, role);
      Session.currentRole = role;
      if (role == 'Pet Owner') {
        Navigator.pushReplacementNamed(context, '/owner');
      } else if (role == 'Veterinarian') {
        Navigator.pushReplacementNamed(context, '/vet');
      } else {
        Navigator.pushReplacementNamed(context, '/shelter');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 12),
            const Text(
              "Choose your role to get started.",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            RoleCard(
              bg: Colors.cyan[50]!,
              title: "Pet Owner",
              tColor: Colors.teal,
              subtitle: "Manage your pet’s health and appointments.",
              asset: 'assets/role_owner.png',
              onTap: () => _pick(context, 'Pet Owner'),
            ),
            RoleCard(
              bg: Colors.blue[50]!,
              title: "Veterinarian",
              tColor: Colors.blue,
              subtitle: "Access patient records and streamline care.",
              asset: 'assets/role_vet.png',
              onTap: () => _pick(context, 'Veterinarian'),
            ),
            RoleCard(
              bg: Colors.purple[50]!,
              title: "Shelter Admin",
              tColor: Colors.purple,
              subtitle: "Manage adoption listings and requests.",
              asset: 'assets/role_shelter.png',
              onTap: () => _pick(context, 'Shelter Admin'),
            ),
          ],
        ),
      ),
    );
  }
}
