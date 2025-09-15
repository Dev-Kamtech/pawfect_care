import 'package:flutter/material.dart';
import 'package:pawfect_care/Shelter_screens/add_pet_listing_page.dart';
import 'package:pawfect_care/Shelter_screens/pet_quick_view.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class AdoptablePetsPage extends StatelessWidget {
  const AdoptablePetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pets = [
      {
        "name": "Buddy",
        "sub": "Labrador Retriever, 2 yrs",
        "img": "https://images.unsplash.com/photo-1543466835-00a7907e9de1",
      },
      {
        "name": "Bella",
        "sub": "Golden Retriever, 3 yrs",
        "img": "https://images.unsplash.com/photo-1548199973-03cce0bbc87b",
      },
      {
        "name": "Max",
        "sub": "German Shepherd, 1 yr",
        "img": "https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9",
      },
      {
        "name": "Lucy",
        "sub": "Poodle, 4 yrs",
        "img": "https://images.unsplash.com/photo-1541364983171-a8ba01e95cfc",
      },
      {
        "name": "Charlie",
        "sub": "Beagle, 2 yrs",
        "img": "https://images.unsplash.com/photo-1507149833265-60c372daea22",
      },
      {
        "name": "Daisy",
        "sub": "Shih Tzu, 5 yrs",
        "img": "https://images.unsplash.com/photo-1505628346881-b72b27e84530",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Adoptable Pets"),
        centerTitle: true,
      ),
      backgroundColor: whiteBgColor,
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        // Taller tiles to prevent bottom overflow
        childAspectRatio: 0.75,
        children: pets.map((p) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PetQuickView(
                    name: p["name"]!,
                    imageUrl: p["img"]!,
                    subtitle: p["sub"]!,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shadowColor: const Color(0x33000000),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image fills available space to avoid overflow
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          p["img"]!,
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
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      p["name"]!,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Text(
                      p["sub"]!,
                      style: const TextStyle(color: Colors.black54, height: 1.2),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddPetListingPage()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
