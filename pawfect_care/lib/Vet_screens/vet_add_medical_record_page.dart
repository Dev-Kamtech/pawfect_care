import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';

class VetAddMedicalRecordPage extends StatefulWidget {
  const VetAddMedicalRecordPage({super.key});

  @override
  State<VetAddMedicalRecordPage> createState() => _VetAddMedicalRecordPageState();
}

class _VetAddMedicalRecordPageState extends State<VetAddMedicalRecordPage> {
  String dateText = "Select Date";

  @override
  Widget build(BuildContext context) {
    InputDecoration d(String h, {Widget? suffix}) => InputDecoration(
      hintText: h,
      filled: true,
      fillColor: const Color(0xFFF1F6F7),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      suffixIcon: suffix,
    );

    return Scaffold(
      backgroundColor: whiteBgColor,
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Add Medical Record"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          InkWell(
            onTap: () async {
              final dPick = await showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                initialDate: DateTime.now(),
              );
              if (dPick != null) {
                setState(() {
                  dateText = "${dPick.year}-${dPick.month.toString().padLeft(2,'0')}-${dPick.day.toString().padLeft(2,'0')}";
                });
              }
            },
            child: TextField(enabled: false, decoration: d(dateText, suffix: const Icon(Icons.calendar_today))),
          ),
          const SizedBox(height: 12),
          TextField(decoration: d("Enter Diagnosis")),
          const SizedBox(height: 12),
          SizedBox(height: 120, child: TextField(maxLines: null, decoration: d("Add Notes"))),
          const SizedBox(height: 12),
          TextField(decoration: d("Enter Prescription")),
          const SizedBox(height: 20),
          Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFDFE7EC), style: BorderStyle.solid),
            ),
            child: const Center(child: Text("Upload File (UI only)")),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: blueButtonColor, foregroundColor: Colors.white),
              child: const Text("Save Record"),
            ),
          ),
        ],
      ),
    );
  }
}
