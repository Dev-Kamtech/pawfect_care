import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:pawfect_care/Pet_Owner_Screens/product_detail_dummy.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "title": "Premium Dog Food",
        "price": "\$29.99",
        "image":
            "https://images.unsplash.com/photo-1601979032126-27b4f2b24e82", // dog food
        "desc":
            "High-quality, nutritious dog food for all breeds and sizes. Made with real meat and essential vitamins and minerals."
      },
      {
        "title": "Catnip Bliss Treats",
        "price": "\$9.99",
        "image":
            "https://images.unsplash.com/photo-1592194996308-7b43878e84a6", // cat treats
        "desc":
            "Tasty treats made with premium catnip. Perfect for playtime rewards and training."
      },
      {
        "title": "Interactive Puzzle Toy",
        "price": "\$14.99",
        "image":
            "https://images.unsplash.com/photo-1619983081655-53db24ec1d4e", // toy
        "desc":
            "Simple puzzle toy that keeps pets busy and mentally stimulated during the day."
      },
      {
        "title": "Flea & Tick Prevention",
        "price": "\$19.99",
        "image":
            "https://images.unsplash.com/photo-1622202176356-d3d3f7fbe048", // flea prevention
        "desc":
            "Easy apply formula that helps protect your pet from fleas and ticks."
      },
    ];

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: const Text("Store",
              style: TextStyle(fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.teal,
            isScrollable: true,
            tabs: [
              Tab(text: "Food"),
              Tab(text: "Grooming"),
              Tab(text: "Toys"),
              Tab(text: "Health"),
            ],
          ),
          actions: const [
            Padding(
                padding: EdgeInsets.only(right: 12), child: Icon(Icons.search))
          ],
        ),
        backgroundColor: const Color(0xFFF5F5F7),
        body: TabBarView(
          children: [
            _grid(context, items),
            _grid(context, items),
            _grid(context, items),
            _grid(context, items),
          ],
        ),
      ),
    );
  }

  Widget _grid(BuildContext context, List<Map<String, String>> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final p = items[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailDummyPage(
                  title: p["title"]!,
                  price: p["price"]!,
                  image: p["image"]!,
                  desc: p["desc"]!,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Color(0x11000000), blurRadius: 6),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top image without ClipRRect; use decoration to avoid overflow
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF3F6),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(p["image"]!),
                      fit: BoxFit.cover,
                      onError: (_, __) {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                  child: Text(
                    p["title"] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
                  child: Text(
                    p["price"] ?? '',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                  child: SizedBox(
                    height: 36,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blueButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Buy",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
