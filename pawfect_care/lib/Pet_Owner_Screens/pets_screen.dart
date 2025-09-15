import 'package:flutter/material.dart';
import 'package:pawfect_care/Pet_Owner_Screens/add_pet_page.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:pawfect_care/widgets/pet_card.dart';
import 'package:pawfect_care/db_helper.dart';
import 'package:pawfect_care/session.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  late Future<List<Map<String, dynamic>>> _petsFuture;

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  void _loadPets() {
    final uid = Session.currentUserId ?? 0;
    _petsFuture = DBHelper.petsByUser(uid);
  }

  Future<void> _refresh() async {
    setState(() {
      _loadPets();
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = Session.currentUserId;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Pets",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: whiteBgColor,
      body: uid == null
          ? const Center(child: Text("Please login first"))
          : FutureBuilder<List<Map<String, dynamic>>>(
              future: _petsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                final pets = snapshot.data ?? [];
                if (pets.isEmpty) {
                  return const Center(
                    child: Text("No pets yet. Add your first pet!"),
                  );
                }
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: pets.length,
                    itemBuilder: (context, i) {
                      final p = pets[i];
                      return PetCard(
                        petId: p['id'] as int, // ← pass id
                        name: (p['name'] ?? '') as String,
                        years: int.tryParse((p['age'] ?? '0') as String) ?? 0,
                        breed: (p['breed'] ?? '') as String,
                        imagePath:
                            (p['photo_path'] ?? 'assets/icon-1.png') as String,
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: blueButtonColor,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPetPage()),
          );
          _refresh(); // reload when coming back
        },
      ),
    );
  }
}
