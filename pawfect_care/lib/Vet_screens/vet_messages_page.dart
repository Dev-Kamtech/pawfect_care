import 'package:flutter/material.dart';
import 'package:pawfect_care/theme/theme.dart';

class VetMessagesPage extends StatelessWidget {
  const VetMessagesPage({super.key});

  Widget bubble(String who, String text, bool me) {
    return Align(
      alignment: me ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: me ? const Color(0xFFE6F7FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 4)],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(who, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Text(text),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = TextEditingController();
    return Scaffold(
      backgroundColor: whiteBgColor,
      appBar: AppBar(
        backgroundColor: whiteBgColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Messages"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                bubble("Owner • Sarah", "Hi doctor, can I reschedule?", false),
                bubble("You", "Sure, what time works?", true),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Color(0x11000000), blurRadius: 6)]),
            child: Row(
              children: [
                Expanded(child: TextField(controller: c, decoration: const InputDecoration(hintText: "Type a message", border: InputBorder.none))),
                IconButton(onPressed: () { c.clear(); }, icon: const Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
