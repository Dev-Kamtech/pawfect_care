import 'package:flutter/material.dart';
import 'package:pawfect_care/db_helper.dart';
import 'package:pawfect_care/session.dart';
import 'package:pawfect_care/theme/theme.dart';

class EditProfilePage extends StatefulWidget {
  final String startName;
  final String startEmail;
  final String startPhone;
  final String startRole;

  const EditProfilePage({
    super.key,
    required this.startName,
    required this.startEmail,
    required this.startPhone,
    required this.startRole,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  String? role;

  @override
  void initState() {
    super.initState();
    name.text = widget.startName;
    email.text = widget.startEmail;
    phone.text = widget.startPhone;
    // Normalize incoming role to one of the allowed values or null
    final r = widget.startRole.trim().toLowerCase();
    if (r.contains('shelter')) {
      role = 'shelter';
    } else if (r.contains('vet')) {
      role = 'vet';
    } else if (r.contains('owner') || r.contains('pet')) {
      role = 'pet_owner';
    } else {
      role = null; // allow user to pick
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final id = Session.currentUserId ?? 0;
    // beginner-simple update
    final db = await DBHelper.getDb();
    await db.update(
      'users',
      {
        'name': name.text,
        'email': email.text.trim().toLowerCase(),
        'phone': phone.text,
        'role': role,
      },
      where: 'id=?',
      whereArgs: [id],
    );
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  InputDecoration _d(String h) => InputDecoration(
        hintText: h,
        filled: true,
        fillColor: const Color(0xFFF2F6F7),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgColor,
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Stack(
              children: const [
                CircleAvatar(
                  radius: 56,
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1527980965255-d3b416303d12",
                  ),
                ),
                // pencil is just UI now
              ],
            ),
          ),
          const SizedBox(height: 16),

          const Text("Name"),
          const SizedBox(height: 6),
          TextField(controller: name, decoration: _d("Buddy")),
          const SizedBox(height: 12),

          const Text("Email"),
          const SizedBox(height: 6),
          TextField(controller: email, decoration: _d("buddy@example.com")),
          const SizedBox(height: 12),

          const Text("Phone"),
          const SizedBox(height: 6),
          TextField(controller: phone, decoration: _d("+1 234 567 890")),
          const SizedBox(height: 12),

          const Text("Role"),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: const {"pet_owner", "vet", "shelter"}.contains(role) ? role : null,
            items: const [
              DropdownMenuItem(value: "pet_owner", child: Text("Pet Owner")),
              DropdownMenuItem(value: "vet", child: Text("Vet")),
              DropdownMenuItem(value: "shelter", child: Text("Shelter")),
            ],
            onChanged: (v) => setState(() => role = v),
            decoration: _d("Select role"),
            isExpanded: true,
          ),
          const SizedBox(height: 20),

          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(backgroundColor: blueButtonColor, foregroundColor: Colors.white),
              child: const Text("Save Changes"),
            ),
          ),
        ],
      ),
    );
  }
}
