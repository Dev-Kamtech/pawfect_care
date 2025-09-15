import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:pawfect_care/Vet_screens/vet_add_medical_record_page.dart';

class VetMedicalRecordsPage extends StatelessWidget {
  const VetMedicalRecordsPage({super.key});

  Widget card(Color dot, IconData icon, String date, String title, String note) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 8)],
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: dot.withOpacity(.15), child: Icon(icon, color: dot)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Visit Date: $date", style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text("Diagnosis: $title", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 12),
              const Text("Prescription:", style: TextStyle(fontWeight: FontWeight.w700)),
              Text(note),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgColor,
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Medical Records", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              card(Colors.teal, Icons.calendar_month, "2024-07-20", "Canine Parvovirus",
                  "IV fluids, antibiotics, antiemetics"),
              card(Colors.indigo, Icons.vaccines, "2024-07-15", "Kennel Cough",
                  "Cough suppressant, antibiotics"),
              card(Colors.green, Icons.health_and_safety, "2024-07-10", "Routine Checkup", "None"),
              const SizedBox(height: 90),
            ],
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: SizedBox(
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const VetAddMedicalRecordPage()));
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Record"),
                style: ElevatedButton.styleFrom(backgroundColor: blueButtonColor, foregroundColor: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
