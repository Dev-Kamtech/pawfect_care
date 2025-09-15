import 'package:flutter/material.dart';
import 'package:pawfect_care/Shelter_screens/add_success_story_page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pawfect_care/theme/theme.dart';

class SuccessStoriesPage extends StatelessWidget {
  const SuccessStoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "t": "Buddy & Sarah",
        "img": "https://images.unsplash.com/photo-1508672019048-805c876b67e2",
      },
      {
        "t": "Max & Alex",
        "img": "https://images.unsplash.com/photo-1543852786-1cf6624b9987",
      },
      {
        "t": "Bella & Emily",
        "img": "https://images.unsplash.com/photo-1517849845537-4d257902454a",
      },
      {
        "t": "Rocky & David",
        "img": "https://images.unsplash.com/photo-1543466835-00a7907e9de1",
      },
      {
        "t": "Luna & Olivia",
        "img": "https://images.unsplash.com/photo-1548199973-03cce0bbc87b",
      },
      {
        "t": "Charlie & Ethan",
        "img": "https://images.unsplash.com/photo-1507149833265-60c372daea22",
      },
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Success Stories"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        // Taller tiles to accommodate title without overflow
        childAspectRatio: 0.8,
        children: items.map((x) {
          return Card(
            elevation: 4,
            shadowColor: const Color(0x33000000),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        x["img"]!,
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
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Text(
                    x["t"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddSuccessStoryPage()),
            ),
            icon: const Icon(Icons.add),
            label: const Text("Add Your Story"),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
