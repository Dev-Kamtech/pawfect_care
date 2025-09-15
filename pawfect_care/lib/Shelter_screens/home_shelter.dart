import 'package:flutter/material.dart';
import 'package:pawfect_care/Shelter_screens/add_pet_listing_page.dart';
import 'package:pawfect_care/Shelter_screens/add_success_story_page.dart';
import 'package:pawfect_care/Shelter_screens/adoptable_pets_page.dart';
import 'package:pawfect_care/Shelter_screens/adoption_request_page.dart';
import 'package:pawfect_care/Shelter_screens/contact_volunteer_page.dart';
import 'package:pawfect_care/Shelter_screens/success_stories_page.dart';
import 'package:pawfect_care/theme/theme.dart';

class ShelterHomeScreen extends StatelessWidget {
  const ShelterHomeScreen({super.key});

  Widget box(String title, String big, Color bg) {
    return Expanded(
      child: Container(
        height: 110,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bg, borderRadius: BorderRadius.circular(16),
          border: Border.all(color: bg.withOpacity(.5)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Text(big, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget bigBtn(BuildContext c, IconData ic, String t, Widget page, {Color? bg, Color? fg}) {
    return SizedBox(
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.push(c, MaterialPageRoute(builder: (_) => page)),
        icon: Icon(ic),
        label: Text(t),
        style: ElevatedButton.styleFrom(
          backgroundColor: bg ?? const Color(0xFF17C1E8),
          foregroundColor: fg ?? Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Shelter Dashboard"),
        centerTitle: true,
        actions: const [Icon(Icons.notifications_none), SizedBox(width: 12)],
      ),
      backgroundColor: whiteBgColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              box("Active Listings", "24", const Color(0xFFEFFBF3)),
              box("Pending Requests", "8", const Color(0xFFEAF4FF)),
            ],
          ),
          Row(
            children: [
              box("Success Stories", "15", const Color(0xFFEFFBF3)),
              box("Donations", "\$1,250", const Color(0xFFEAFBFF)),
            ],
          ),
          const SizedBox(height: 16),
          bigBtn(context, Icons.add, "Add Pet", const AddPetListingPage(), bg: blueButtonColor, fg: Colors.white),
          const SizedBox(height: 10),
          bigBtn(context, Icons.rule, "View Requests", const AdoptionRequestsPage(),
              bg: const Color(0xFFF1F3F6), fg: Colors.black87),
          const SizedBox(height: 10),
          bigBtn(context, Icons.share, "Share Story", const AddSuccessStoryPage(),
              bg: const Color(0xFFF1F3F6), fg: Colors.black87),
          const SizedBox(height: 16),
          // quick links
          Wrap(
            spacing: 10, runSpacing: 10,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdoptablePetsPage())),
                child: const Text("Adoptable Pets"),
              ),
              OutlinedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SuccessStoriesPage())),
                child: const Text("Success Stories"),
              ),
              OutlinedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactVolunteerPage())),
                child: const Text("Contact & Volunteer"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
