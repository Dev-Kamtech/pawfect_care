import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class VetAppointmentsPage extends StatelessWidget {
  const VetAppointmentsPage({super.key});

  Widget item(String img, String title, String time, IconData trailingIcon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 6)],
      ),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox(
              width: 56,
              height: 56,
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
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(time, style: const TextStyle(color: Colors.blueGrey)),
            ]),
          ),
          CircleAvatar(
            backgroundColor: const Color(0xFFEFF9F0),
            child: Icon(trailingIcon, color: Colors.teal),
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
        title: const Text("Appointments"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 6)],
            ),
            child: Column(
              children: const [
                Text("July 2024", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("— calendar UI placeholder —", style: TextStyle(color: Colors.blueGrey)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text("Today's Appointments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          item("https://images.unsplash.com/photo-1543466835-00a7907e9de1", "Checkup for Max", "10:00 AM - 11:00 AM", Icons.check),
          item("https://images.unsplash.com/photo-1519052534-7a3c43aabd0c", "Vaccination for Bella", "11:30 AM - 12:30 PM", Icons.vaccines),
          item("https://images.unsplash.com/photo-1552053831-71594a27632d", "Follow-up for Charlie", "2:00 PM - 3:00 PM", Icons.event_repeat),
          const SizedBox(height: 90),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: blueButtonColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Add Availability"),
      ),
    );
  }
}
