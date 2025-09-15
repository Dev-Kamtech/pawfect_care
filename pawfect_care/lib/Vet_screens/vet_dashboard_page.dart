import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pawfect_care/Vet_screens/vet_appointments_page.dart';
import 'package:pawfect_care/Vet_screens/vet_medical_records_page.dart';

class VetDashboardPage extends StatelessWidget {
  const VetDashboardPage({super.key});

  Widget chip(String t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3FBFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE6F2F8)),
      ),
      child: Text(t, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }

  Widget apptItem(String img, String title, String owner, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6EEFF)),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 4)],
      ),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox(
              width: 72,
              height: 72,
              child: Image.network(
                img,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: const Color(0xFFE0E0E0),
                    highlightColor: const Color(0xFFF5F5F5),
                    child: Container(color: const Color(0xFFE0E0E0)),
                  );
                },
                errorBuilder: (_, __, ___) => Container(color: const Color(0xFFEFF3F6)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Owner: $owner", style: const TextStyle(color: Colors.blueGrey)),
                Row(children: [const Icon(Icons.access_time, size: 16), const SizedBox(width: 6), Text(time)]),
              ],
            ),
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
        title: const Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Today's Appointments", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          apptItem(
            "https://images.unsplash.com/photo-1558944351-bf6f9f8c0f48",
            "Checkup for Max",
            "Sarah Miller",
            "10:00 AM - 11:00 AM",
          ),
          apptItem(
            "https://images.unsplash.com/photo-1518791841217-8f162f1e1131",
            "Vaccination for Bella",
            "Michael Chen",
            "11:30 AM - 12:30 PM",
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const VetMedicalRecordsPage()));
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text("Add Record"),
                  style: ElevatedButton.styleFrom(backgroundColor: blueButtonColor, foregroundColor: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const VetAppointmentsPage()));
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text("Manage Calendar"),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.black87),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text("Assigned Pets", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F8FF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE6EEFF)),
            ),
            child: ListTile(
              leading: ClipOval(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.network(
                    "https://images.unsplash.com/photo-1543466835-00a7907e9de1",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: const Color(0xFFE0E0E0),
                        highlightColor: const Color(0xFFF5F5F5),
                        child: Container(color: const Color(0xFFE0E0E0)),
                      );
                    },
                    errorBuilder: (_, __, ___) => Container(color: const Color(0xFFEFF3F6)),
                  ),
                ),
              ),
              title: const Text("Buddy"),
              subtitle: const Text("Dog, 3 years old"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F8FF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE6EEFF)),
            ),
            child: ListTile(
              leading: ClipOval(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.network(
                    "https://images.unsplash.com/photo-1519052534-7a3c43aabd0c",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: const Color(0xFFE0E0E0),
                        highlightColor: const Color(0xFFF5F5F5),
                        child: Container(color: const Color(0xFFE0E0E0)),
                      );
                    },
                    errorBuilder: (_, __, ___) => Container(color: const Color(0xFFEFF3F6)),
                  ),
                ),
              ),
              title: const Text("Whiskers"),
              subtitle: const Text("Cat, 5 years old"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
