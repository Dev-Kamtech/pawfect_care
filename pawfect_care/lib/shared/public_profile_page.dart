import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:pawfect_care/db_helper.dart';
import 'package:pawfect_care/session.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'edit_profile_page.dart';

String _badgeText(String? role) {
  if (role == null) return "Role";
  final r = role.toLowerCase().trim();
  if (r.contains("vet")) return "Vet";
  if (r.contains("shelter")) return "Shelter";
  return "Pet"; // pet owner or anything else
}

class PublicProfilePage extends StatefulWidget {
  const PublicProfilePage({super.key});

  @override
  State<PublicProfilePage> createState() => _PublicProfilePageState();
}

class _PublicProfilePageState extends State<PublicProfilePage> {
  Map<String, dynamic>? user;

  Future<void> _load() async {
    final id = Session.currentUserId ?? 0;
    final u = await DBHelper.getUser(id);
    setState(() {
      user = u ?? {};
    });
  }

  Future<void> _pickAvatar() async {
    try {
      final picker = ImagePicker();
      final XFile? file = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      final id = Session.currentUserId ?? 0;
      if (id == 0) return;
      await DBHelper.updateUserPhotoBytes(id, bytes);
      await _load();
    } catch (_) {
      // ignore picker errors
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final name = (user?['name'] ?? '').toString();
    final email = (user?['email'] ?? '').toString();
    final phone = (user?['phone'] ?? '').toString();
    final role = (user?['role'] ?? '').toString();
    final tag = _badgeText(role);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Profile"),
        centerTitle: true,
      ),
      backgroundColor: whiteBgColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          Center(
            child: GestureDetector(
              onTap: _pickAvatar,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: (user != null && user!['photo_bytes'] != null)
                        ? MemoryImage(user!['photo_bytes'] as Uint8List)
                        : const NetworkImage(
                            "https://images.unsplash.com/photo-1527980965255-d3b416303d12",
                          ) as ImageProvider,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 6)],
                      ),
                      child: Text(tag, style: const TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              name.isEmpty ? "Your Name" : name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              email.isEmpty ? "email@example.com" : email,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              phone.isEmpty ? "+1 (000) 000-0000" : phone,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 20),

          // Edit profile
          Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 6)],
            ),
            child: ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit Profile"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final changed = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfilePage(
                      startName: name,
                      startEmail: email,
                      startPhone: phone,
                      startRole: role,
                    ),
                  ),
                );
                if (changed == true) {
                  _load();
                }
              },
            ),
          ),
          const SizedBox(height: 12),

          // Change password (optional: navigate to your reset page)
          Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 6)],
            ),
            child: ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text("Change Password"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Route defined in main.dart as '/forgot'
                Navigator.pushNamed(context, '/forgot');
              },
            ),
          ),
          const SizedBox(height: 12),

          // Logout
          Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 6)],
            ),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              trailing: const Icon(Icons.chevron_right, color: Colors.red),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
