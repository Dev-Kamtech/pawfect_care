import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';

class AdoptionRequestsPage extends StatelessWidget {
  const AdoptionRequestsPage({super.key});

  Widget card(String name, String msg, String avatarUrl) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 6)],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
          const SizedBox(width: 10),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ]),
        const SizedBox(height: 8),
        Text(msg, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: ElevatedButton(onPressed: () {}, child: const Text("Approve"))),
          const SizedBox(width: 8),
          Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Reject"))),
        ]),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final people = [
      {"n": "Sarah Miller", "m": "I’m excited to provide a loving home.", "a": "https://randomuser.me/api/portraits/women/68.jpg"},
      {"n": "Mark Thompson", "m": "I have a yard and time for walks.", "a": "https://randomuser.me/api/portraits/men/44.jpg"},
      {"n": "Emily Davis", "m": "Flexible schedule and companion!", "a": "https://randomuser.me/api/portraits/women/12.jpg"},
    ];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: whiteBgColor,
        appBar: AppBar(
          backgroundColor: whiteBgColor,
          foregroundColor: Colors.black,
          elevation: 0,
          title: const Text("Adoption Requests"),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            indicatorColor: blueButtonColor,
            tabs: const [Tab(text: "Pending"), Tab(text: "Approved"), Tab(text: "Rejected")],
          ),
        ),
        body: TabBarView(children: [
          ListView(children: people.map((p) => card(p["n"]!, p["m"]!, p["a"]!)).toList()),
          const Center(child: Text("No approved yet")),
          const Center(child: Text("No rejected yet")),
        ]),
      ),
    );
  }
}
