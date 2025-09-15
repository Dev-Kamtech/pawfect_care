// lib/Pet_Owner_Screens/book_appointment_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pawfect_care/db_helper.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:pawfect_care/session.dart';

class BookAppointmentPage extends StatefulWidget {
  
  final int petId; // comes from PetDetails; we still allow changing it
  const BookAppointmentPage({super.key, required this.petId});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  // vets (simple static for now)
  List<Map<String, dynamic>> vets = [
    {
      "id": 1,
      "name": "Dr. Emily Carter",
      "sub": "Veterinary Clinic",
      "avatar": "assets/images/vet1.png",
    },
    {
      "id": 2,
      "name": "Dr. Michael Chen",
      "sub": "Veterinary Clinic",
      "avatar": "assets/images/vet2.png",
    },
  ];

  // pets for dropdown
  List<Map<String, dynamic>> pets = [];
  int? petIdSelected;

  int? vetId;
  String? dateTimeText;
  String? reason;
  bool saving = false;
  String? error;

  @override
  void initState() {
    super.initState();
    petIdSelected = widget.petId; // default to pet we came from
    _loadPets();
  }

  Future<void> _loadPets() async {
    final uid = Session.currentUserId ?? 0;
    final rows = await DBHelper.petsByUser(uid);
    setState(() => pets = rows);
  }

  ImageProvider _petImage(String? path) {
    if (path == null || path.isEmpty)
      return const AssetImage('assets/icon-1.png');
    if (path.startsWith('/') || path.startsWith('file:'))
      return FileImage(File(path));
    return AssetImage(path);
  }

  Future<void> _pickDateTime() async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (d == null) return;
    final t = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (t == null) return;
    final dt = DateTime(d.year, d.month, d.day, t.hour, t.minute);
    setState(() {
      final y = dt.year.toString();
      final m = dt.month.toString().padLeft(2, '0');
      final dd = dt.day.toString().padLeft(2, '0');
      dateTimeText = "$y-$m-$dd ${t.format(context)}";
    });
  }

  Future<void> _save() async {
    setState(() {
      saving = true;
      error = null;
    });
    if (petIdSelected == null ||
        vetId == null ||
        dateTimeText == null ||
        (reason ?? "").isEmpty) {
      setState(() {
        saving = false;
        error = "Please select pet, vet, date/time and reason";
      });
      return;
    }
    await DBHelper.addAppointment(
      petId: petIdSelected!,
      veterinarianId: vetId!,
      dateTime: dateTimeText!,
      status: 'upcoming',
      notes: reason,
    );
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Book Appointment",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: whiteBgColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // PET DROPDOWN (with image + name)
          const Text("Pet", style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _box(
            pets.isEmpty
                ? const ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/icon-1.png'),
                    ),
                    title: Text("No pets found"),
                    subtitle: Text("Add a pet first"),
                  )
                : DropdownButtonFormField<int>(
                    value: petIdSelected,
                    items: pets.map((p) {
                      // SAFE reads (no `as String`)
                      final id = int.tryParse(p['id'].toString()) ?? 0;
                      final nm = (p['name'] ?? '').toString();
                      final sp = (p['species'] ?? '').toString();
                      final ph = (p['photo_path'] ?? '').toString();

                      return DropdownMenuItem<int>(
                        value: id,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: _petImage(ph),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              nm,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (sp.isNotEmpty) ...[
                              const SizedBox(width: 6),
                              Text(
                                "($sp)",
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (v) => setState(() => petIdSelected = v),
                    decoration: const InputDecoration(border: InputBorder.none),
                    icon: const Icon(Icons.expand_more),
                  ),
          ),

          const SizedBox(height: 16),

          // VET
          const Text("Vet", style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _box(
            DropdownButtonFormField<int>(
              value: vetId,
              items: vets.map((v) {
                return DropdownMenuItem<int>(
                  value: v["id"] as int,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(v["avatar"] as String),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            v["name"] as String,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            v["sub"] as String,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (v) => setState(() => vetId = v),
              decoration: const InputDecoration(border: InputBorder.none),
              icon: const Icon(Icons.expand_more),
            ),
          ),

          const SizedBox(height: 16),

          // DATE & TIME
          const Text(
            "Date & Time",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: _pickDateTime,
            child: _pill(dateTimeText ?? "Select Date & Time"),
          ),

          const SizedBox(height: 16),

          // REASON
          const Text("Reason", style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _box(
            DropdownButtonFormField<String>(
              value: reason,
              items: const [
                DropdownMenuItem(
                  value: "Vaccination",
                  child: Text("Vaccination"),
                ),
                DropdownMenuItem(value: "Check-up", child: Text("Check-up")),
                DropdownMenuItem(value: "Deworming", child: Text("Deworming")),
              ],
              onChanged: (v) => setState(() => reason = v),
              decoration: const InputDecoration(border: InputBorder.none),
              icon: const Icon(Icons.expand_more),
            ),
          ),

          const SizedBox(height: 12),
          if (error != null)
            Text(error!, style: const TextStyle(color: Colors.red)),

          const SizedBox(height: 20),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: blueButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text(
                saving ? "Please wait…" : "Confirm",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _box(Widget child) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 6)],
      ),
      child: child,
    );
  }

  Widget _pill(String text) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE7EDF2)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(text, style: const TextStyle(color: Colors.black87)),
          const Spacer(),
          const Icon(Icons.calendar_today_outlined, size: 18),
        ],
      ),
    );
  }
}
