import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Appointments",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            indicatorColor: blueButtonColor,
            tabs: const [
              Tab(text: "Upcoming"),
              Tab(text: "Past"),
              Tab(text: "Cancelled"),
            ],
          ),
        ),
        backgroundColor: whiteBgColor,
        body: TabBarView(
          children: [
            // UPCOMING TAB
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _appointmentCard(
                  vetName: "Dr. Emily Carter",
                  petLine: "Buddy (Dog) · 10/26/2024 · 2:00 PM",
                  avatar: "assets/images/vet1.png",
                ),
                const SizedBox(height: 12),
                _appointmentCard(
                  vetName: "Dr. Michael Chen",
                  petLine: "Whiskers (Cat) · 11/15/2024 · 10:00 AM",
                  avatar: "assets/images/vet2.png",
                ),
              ],
            ),
            // PAST TAB
            const Center(child: Text("No past appointments")),
            // CANCELLED TAB
            const Center(child: Text("No cancelled appointments")),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: blueButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                "Book Appointment",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appointmentCard({
    required String vetName,
    required String petLine,
    required String avatar,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 6)],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.circle, size: 10, color: blueButtonColor),
              const SizedBox(width: 6),
              Text(
                "CONFIRMED",
                style: TextStyle(
                  color: blueButtonColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(radius: 26, backgroundImage: AssetImage(avatar)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vetName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      petLine,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
