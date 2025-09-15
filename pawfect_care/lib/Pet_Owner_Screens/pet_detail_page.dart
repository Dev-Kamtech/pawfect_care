// lib/Pet_Owner_Screens/pet_detail_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pawfect_care/Pet_Owner_Screens/book_appointments.dart';
import 'package:pawfect_care/theme/theme.dart';
import 'package:pawfect_care/db_helper.dart';
import 'package:pawfect_care/Pet_Owner_Screens/add_health_page.dart';

class PetDetailsPage extends StatefulWidget {
  final int petId;
  final String name;
  final int years;
  final String breed;
  final String imagePath;

  const PetDetailsPage({
    super.key,
    required this.petId,
    required this.name,
    required this.years,
    required this.breed,
    required this.imagePath,
  });

  @override
  State<PetDetailsPage> createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  late Future<List<Map<String, dynamic>>> _healthFuture;
  late Future<List<Map<String, dynamic>>> _apptsFuture;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _healthFuture = DBHelper.healthByPet(widget.petId);
    _apptsFuture = DBHelper.appointmentsByPet(widget.petId);
  }

  String _pretty(String? d) {
    if (d == null || d.isEmpty) return '';
    final p = d.split('-');
    if (p.length < 3) return d;
    const m = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    final mi = int.tryParse(p[1]) ?? 1;
    return "${m[mi - 1]} ${int.tryParse(p[2]) ?? 1}, ${p[0]}";
  }

  Map<String, dynamic> _status(String? visit, String? nextDue) {
    final now = DateTime.now();
    DateTime? v = DateTime.tryParse(visit ?? "");
    DateTime? n = DateTime.tryParse(nextDue ?? "");
    if (n != null && n.isBefore(now)) {
      return {
        "label": "Overdue",
        "color": Colors.orange,
        "icon": Icons.error,
        "bg": const Color(0xFFFFF2E5),
      };
    }
    if (v != null && v.isAfter(now)) {
      return {
        "label": "Upcoming",
        "color": Colors.blue,
        "icon": Icons.schedule,
        "bg": const Color(0xFFEAF4FF),
      };
    }
    return {
      "label": "Done",
      "color": Colors.teal,
      "icon": Icons.check_circle,
      "bg": const Color(0xFFE6F7F4),
    };
  }

  // tiny map for vet avatars by id (use your own asset paths)
  String _vetAvatar(int id) {
    if (id == 1) return 'assets/images/vet1.png';
    if (id == 2) return 'assets/images/vet2.png';
    return 'assets/icon-1.png';
  }

  String _vetName(int id) {
    if (id == 1) return "Dr. Emily Carter";
    if (id == 2) return "Dr. Michael Chen";
    return "Veterinarian";
  }

  @override
  Widget build(BuildContext context) {
    final isFile =
        widget.imagePath.startsWith('/') ||
        widget.imagePath.startsWith('file:');
    final img = isFile
        ? FileImage(File(widget.imagePath)) as ImageProvider
        : AssetImage(widget.imagePath);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: whiteBgColor,
        body: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 16),
                CircleAvatar(radius: 34, backgroundImage: img),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.breed,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    Text(
                      "Male, ${widget.years} years old",
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              indicatorColor: Colors.teal,
              tabs: [
                Tab(text: "Info"),
                Tab(text: "Health"),
                Tab(text: "Appointments"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // INFO
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "About",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "This pet is friendly and playful.",
                          style: TextStyle(color: Colors.black87, height: 1.4),
                        ),
                      ],
                    ),
                  ),

                  // HEALTH
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Expanded(
                          child: FutureBuilder<List<Map<String, dynamic>>>(
                            future: _healthFuture,
                            builder: (context, snap) {
                              if (snap.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final items = snap.data ?? [];
                              if (items.isEmpty) {
                                return const Center(
                                  child: Text("No health records yet"),
                                );
                              }
                              return ListView.separated(
                                itemCount: items.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, i) {
                                  final r = items[i];
                                  final s = _status(
                                    r['visit_date'] as String?,
                                    r['next_due_date'] as String?,
                                  );
                                  final title =
                                      (r['diagnosis'] ?? 'Health Record')
                                          .toString();
                                  final dateForTile =
                                      r['visit_date']?.toString() ??
                                      r['next_due_date']?.toString() ??
                                      '';
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 22,
                                            height: 22,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: s["color"],
                                                width: 3,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 2,
                                            height: 72,
                                            color: Colors.teal.withOpacity(0.2),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(14),
                                          decoration: BoxDecoration(
                                            color: s["bg"],
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    title,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    s["label"],
                                                    style: TextStyle(
                                                      color: s["color"],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                _pretty(dateForTile),
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final added = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AddHealthPage(petId: widget.petId),
                                ),
                              );
                              if (added == true) setState(_load);
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("Add Health Record"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blueButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // APPOINTMENTS
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Expanded(
                          child: FutureBuilder<List<Map<String, dynamic>>>(
                            future: _apptsFuture,
                            builder: (context, snap) {
                              if (snap.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final items = snap.data ?? [];
                              if (items.isEmpty) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("No appointments yet"),
                                    const SizedBox(height: 12),
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        final added = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => BookAppointmentPage(
                                              petId: widget.petId,
                                            ),
                                          ),
                                        );
                                        if (added == true) setState(_load);
                                      },
                                      icon: const Icon(Icons.add),
                                      label: const Text("Book Appointment"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: blueButtonColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            28,
                                          ),
                                        ),
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return ListView.separated(
                                itemCount: items.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, i) {
                                  final a = items[i];
                                  final vetId =
                                      (a['veterinarian_id'] ?? 0) as int;
                                  final vetName = _vetName(vetId);
                                  final petLine =
                                      "${widget.name} (${widget.breed})";
                                  final dt = (a['date_time'] ?? '')
                                      .toString(); // store plain text like "2024-10-26 14:00"
                                  final avatarPath = _vetAvatar(vetId);
                                  return Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x11000000),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.teal,
                                          size: 10,
                                        ),
                                        const SizedBox(width: 6),
                                        const Text(
                                          "CONFIRMED",
                                          style: TextStyle(
                                            color: Colors.teal,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ).copyWithChild(
                                    // quick trick to stack content below (simple style)
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 28,
                                              backgroundImage: AssetImage(
                                                avatarPath,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    vetName,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "$petLine · $dt",
                                                    style: const TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final added = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    BookAppointmentPage(petId: widget.petId),
                              ),
                            );
                            if (added == true) setState(_load);
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Book Appointment"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueButtonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// simple extension to put extra child under a container content (keeps beginner feel)
extension _WithChild on Widget {
  Widget copyWithChild({required Widget child}) {
    return Column(children: [this, child]);
  }
}
