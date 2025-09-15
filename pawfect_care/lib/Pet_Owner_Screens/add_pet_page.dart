import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:pawfect_care/widgets/custom_input_fields.dart';
import 'package:pawfect_care/db_helper.dart';
import 'package:pawfect_care/session.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});
  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  // text inputs
  final name = TextEditingController();
  final breed = TextEditingController();
  final age = TextEditingController();

  // dropdown data (simple lists)
  List<String> speciesList = [
    "Dog",
    "Cat",
    "Bird",
    "Rabbit",
    "Other",
    "Add new…",
  ];
  List<String> genderList = ["Male", "Female", "Add new…"];

  String? species;
  String? gender;

  // photo path
  String? photoPath;

  bool saving = false;
  String? error;

  @override
  void dispose() {
    name.dispose();
    breed.dispose();
    age.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        photoPath = file.path;
      });
    }
  }

  Future<void> _maybeAddToList({
    required List<String> list,
    required String picked,
    required void Function(String) onPickedRealValue,
  }) async {
    if (picked == "Add new…") {
      final controller = TextEditingController();
      final val = await showDialog<String>(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("Add new"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Type here"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, controller.text.trim()),
                child: const Text("Save"),
              ),
            ],
          );
        },
      );
      if (val != null && val.isNotEmpty) {
        setState(() {
          // insert before the "Add new…" item so it stays last
          list.insert(list.length - 1, val);
          onPickedRealValue(val);
        });
      }
    } else {
      onPickedRealValue(picked);
      setState(() {});
    }
  }

  Future<void> _save() async {
    setState(() {
      saving = true;
      error = null;
    });

    if (name.text.trim().isEmpty) {
      setState(() {
        saving = false;
        error = "Please enter pet name";
      });
      return;
    }
    if (Session.currentUserId == null) {
      setState(() {
        saving = false;
        error = "No user session";
      });
      return;
    }

    await DBHelper.addPet(
      userId: Session.currentUserId!,
      name: name.text.trim(),
      species: species,
      breed: breed.text.trim().isEmpty ? null : breed.text.trim(),
      age: age.text.trim().isEmpty ? null : age.text.trim(),
      gender: gender,
      photoPath: photoPath,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Pet saved")));
    Navigator.pop(context); // go back to Pets list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteBgColor,
        foregroundColor: blackBgColor,
        title: const Text(
          "Add a New Pet",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 4),

          // photo + pencil
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: photoPath == null
                      ? const AssetImage('assets/icon-1.png') as ImageProvider
                      : FileImage(File(photoPath!)),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: _pickPhoto,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: blueButtonColor,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              "Add a photo of your pet",
              style: TextStyle(color: Colors.black54),
            ),
          ),

          const SizedBox(height: 24),

          // Name
          const Text("Name", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          CustomInputField(
            hint: "e.g., Buddy",
            icon: Icons.pets,
            controller: name,
            obscureText: false,
          ),

          const SizedBox(height: 16),

          // Species
          const Text("Species", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: species,
            items: speciesList
                .map((s) => DropdownMenuItem<String>(value: s, child: Text(s)))
                .toList(),
            onChanged: (val) {
              if (val == null) return;
              _maybeAddToList(
                list: speciesList,
                picked: val,
                onPickedRealValue: (v) => species = v,
              );
            },
            decoration: _ddDecoration(),
          ),

          const SizedBox(height: 16),

          // Breed
          const Text("Breed", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          CustomInputField(
            hint: "e.g., Golden Retriever",
            icon: Icons.badge_outlined,
            controller: breed,
            obscureText: false,
          ),

          const SizedBox(height: 16),

          // Age + Gender
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Age",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    CustomInputField(
                      hint: "e.g., 2",
                      icon: Icons.timelapse,
                      controller: age,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gender",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: gender,
                      items: genderList
                          .map(
                            (g) => DropdownMenuItem<String>(
                              value: g,
                              child: Text(g),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val == null) return;
                        _maybeAddToList(
                          list: genderList,
                          picked: val,
                          onPickedRealValue: (v) => gender = v,
                        );
                      },
                      decoration: _ddDecoration(),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          if (error != null)
            Text(error!, style: const TextStyle(color: Colors.red)),

          const SizedBox(height: 8),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: blueButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 2,
              ),
              child: Text(
                saving ? "Please wait..." : "Save Pet",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _ddDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      filled: true,
      fillColor: const Color(0xFFF5F8FA),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE7EDF2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE7EDF2)),
      ),
    );
  }
}
