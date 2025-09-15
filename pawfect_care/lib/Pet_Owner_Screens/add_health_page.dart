// lib/Pet_Owner_Screens/add_health_page.dart
import 'package:flutter/material.dart';
import 'package:pawfect_care/db_helper.dart';
import 'package:pawfect_care/theme/theme.dart';

class AddHealthPage extends StatefulWidget {
  final int petId;
  const AddHealthPage({super.key, required this.petId});

  @override
  State<AddHealthPage> createState() => _AddHealthPageState();
}

class _AddHealthPageState extends State<AddHealthPage> {
  final type = TextEditingController(); // e.g. Vaccination - Rabies
  final notes = TextEditingController(); // optional notes/prescription
  String? visitDate; // YYYY-MM-DD
  String? nextDue; // YYYY-MM-DD
  bool saving = false;
  String? error;

  @override
  void dispose() {
    type.dispose();
    notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate(bool isVisit) async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (d != null) {
      final s =
          "${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
      setState(() {
        if (isVisit)
          visitDate = s;
        else
          nextDue = s;
      });
    }
  }

  Future<void> _save() async {
    setState(() {
      saving = true;
      error = null;
    });
    if (type.text.trim().isEmpty || visitDate == null) {
      setState(() {
        saving = false;
        error = "Please set record type and date";
      });
      return;
    }
    await DBHelper.addHealth(
      petId: widget.petId,
      visitDate: visitDate,
      diagnosis: type.text.trim(), // store type/title here
      prescription: notes.text.trim(), // optional
      nextDueDate: nextDue,
    );
    if (!mounted) return;
    Navigator.pop(context, true); // tell previous page to refresh
  }

  Widget _pill(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F8FA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE7EDF2)),
    ),
    child: Text(text.isEmpty ? "Select date" : text),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Add Health Record",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: whiteBgColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Record Type",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: type,
            decoration: const InputDecoration(
              hintText: "e.g., Vaccination - Rabies",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          const Text("Date", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          InkWell(onTap: () => _pickDate(true), child: _pill(visitDate ?? "")),
          const SizedBox(height: 16),

          const Text(
            "Notes (optional)",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: notes,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: "Add any relevant notes…",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            "Next Due Date (optional)",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          InkWell(onTap: () => _pickDate(false), child: _pill(nextDue ?? "")),

          const SizedBox(height: 16),
          if (error != null)
            Text(error!, style: const TextStyle(color: Colors.red)),

          const SizedBox(height: 12),
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
                saving ? "Please wait…" : "Save Record",
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
}
