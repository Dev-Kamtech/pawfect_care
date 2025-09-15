import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pawfect_care/Pet_Owner_Screens/pets_screen.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:pawfect_care/widgets/dashboard_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 12),
            ClipOval(
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.network(
                  "https://images.unsplash.com/photo-1554151228-14d9def656e4?w=200",
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
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "PawfectCare",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Hello, Sarah!",
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.notifications_none,
              color: Color(0xFF323232),
              size: 30,
            ),
          ),
        ],
      ),
      backgroundColor: whiteBgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "What are you looking for?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    DashboardCard(
                      title: "My Pets",
                      imagePath: "assets/my_pets.png",
                      bgColor: const Color(0xFFEAF7F8),
                      onTap: () {
                      },
                    ),
                    const SizedBox(width: 14),
                    DashboardCard(
                      title: "Health Records",
                      imagePath: "assets/health_records.png",
                      bgColor: const Color(0xFFE5F2F2),
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    DashboardCard(
                      title: "Appointments",
                      imagePath: "assets/appointments.png",
                      bgColor: const Color(0xFFEFF7EE),
                      onTap: () {},
                    ),
                    const SizedBox(width: 14),
                    DashboardCard(
                      title: "Pet Store",
                      imagePath: "assets/pet_store.png",
                      bgColor: const Color(0xFFF2F8E9),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
                const SizedBox(height: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Recent Blogs",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () {
                    // action when tapped
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300, // tiny border line
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://images.unsplash.com/photo-1520880867055-1e30d1cb001c?w=200",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Shimmer.fromColors(
                                baseColor: const Color(0xFFE0E0E0),
                                highlightColor: const Color(0xFFF5F5F5),
                                child: Container(width: 60, height: 60, color: const Color(0xFFE0E0E0)),
                              );
                            },
                            errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: const Color(0xFFEFF3F6)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Keeping Your Pet Happy",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Learn tips and tricks for a joyful companion.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
