import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/add_appointment_popup.dart';

class _DashboardTopBar extends StatelessWidget {
  final VoidCallback onMenuTap;
  const _DashboardTopBar({required this.onMenuTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: Colors.white,
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            IconButton(
              onPressed: onMenuTap,
              icon: Icon(Icons.menu, size: 28, color: Color(0xFF2F2F2F)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17, left: 10, bottom: 8, right: 12),
              child: Text(
                'LiveSure',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Color(0xFF222B45),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2, right: 12),
              child: Icon(Icons.dashboard_customize, size: 22, color: Color(0xFF0C89E4)),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Dashboard',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222B45),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.nightlight_round, color: Color(0xFF5A6474)),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.notifications_none_outlined, color: Color(0xFF5A6474)),
                  onPressed: () {},
                ),
                const SizedBox(width: 5),
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dr. Srujitha Koduri',
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    Text(
                      'General Practitioner',
                      style: GoogleFonts.inter(color: Color(0xFF5c757D), fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// -------------------- Dashboard Screen --------------------
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen> {
  void _openAddAppointmentPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddAppointmentPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          _DashboardTopBar(onMenuTap: () {}),
          Expanded(
            child: Scrollbar(
              thickness: 7,
              thumbVisibility: true,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Text("Today's Overview", style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF222B45))),
                      const SizedBox(height: 22),
                      // OVERVIEW CARDS SPREAD EVENLY, HEIGHT 160
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _OverviewCard(title: 'Appointments', mainValue: '3', subValue1: 'Online: 02', subValue2: 'Offline: 01'),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: _OverviewCard(title: 'Patients', mainValue: '3', subValue1: 'New: 02', subValue2: 'Repeat: 01'),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: _OverviewCard(title: "Today's Earning", mainValue: '\$4500', subValue1: 'Online: \$3000', subValue2: 'Cash: \$1500'),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: _OverviewCard(title: 'Notifications', mainValue: '3', subValue1: 'Unread Chats: 02', subValue2: 'Alert: 01'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      // SCHEDULE + RIGHT BOXES, SCROLLBARS
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Scrollbar(
                              thickness: 7,
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                child: ScheduleTable(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                // NOTIFICATIONS (separate box, with internal scrollbar)
                                Container(
                                  width: double.infinity,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.09), spreadRadius: 1, blurRadius: 10)],
                                  ),
                                  padding: const EdgeInsets.fromLTRB(23, 21, 23, 21),
                                  child: Scrollbar(
                                    thickness: 7,
                                    thumbVisibility: true,
                                    child: ListView(
                                      children: [
                                        Text('Notifications', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 18),
                                        Center(
                                          child: Text('No recent notification', style: GoogleFonts.inter(color: Color(0xFF9EA6B7), fontSize: 15)),
                                        ),
                                        // Add more dummy notifications if needed here
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                // QUICK ACTIONS (separate box, with internal scrollbar)
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                                  padding: const EdgeInsets.all(24),
                                  child: Scrollbar(
                                    thickness: 7,
                                    thumbVisibility: true,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        QuickActionsCard(openAddAppointment: () => _openAddAppointmentPopup(context)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 34),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------- Overview Card --------------------
class _OverviewCard extends StatelessWidget {
  final String title;
  final String mainValue;
  final String subValue1;
  final String subValue2;
  final Widget? child;
  const _OverviewCard({
    Key? key,
    required this.title,
    required this.mainValue,
    required this.subValue1,
    required this.subValue2,
    this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), spreadRadius: 1, blurRadius: 8)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: GoogleFonts.inter(fontSize: 16, color: Color(0xFF5A6474), fontWeight: FontWeight.w700)),
          const SizedBox(height: 5),
          Text(mainValue, style: GoogleFonts.inter(fontSize: 34, fontWeight: FontWeight.bold, color: Color(0xFF222B45))),
          const SizedBox(height: 7),
          Text(subValue1, style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF5A6474))),
          Text(subValue2, style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF5A6474))),
        ],
      ),
    );
  }
}

// -------------------- Schedule Table (Unchanged) --------------------
class ScheduleTable extends StatelessWidget {
  const ScheduleTable({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final rows = [
      ["09:00 AM", "Ethan Carter", "Check-up", "Online", _statusTag("Pending", Color(0xFFFF5858), Colors.white)],
      ["12:30 PM", "Olivia Bennett", "Follow-up", "Online", _statusTag("Completed", Color(0xFFCED2DA), Colors.black)],
      ["03:20 PM", "Noah Thompson", "Consultation", "Physical", _statusTag("Ongoing", Color(0xFFFFD60A), Colors.black)],
      ["12:30 PM", "Sophia Clark", "Follow-up", "Physical", _statusTag("Scheduled", Color(0xFF30D158), Colors.white)],
    ];
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 18, 32, 8),
            child: Row(
              children: [
                Text("Today's Schedule", style: GoogleFonts.inter(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xFF222B45))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(100),
                    1: FlexColumnWidth(),
                    2: FixedColumnWidth(120),
                    3: FixedColumnWidth(90),
                    4: FixedColumnWidth(120),
                  },
                  children: [
                    TableRow(
                      children: [
                        _headerCell('Time'),
                        _headerCell('Patient Name'),
                        _headerCell('Type'),
                        _headerCell('Mode'),
                        _headerCell('Status'),
                      ],
                    ),
                  ],
                ),
                Container(height: 1, color: Color(0xFFE6E8EC)),
                SizedBox(
                  height: 180,
                  child: Scrollbar(
                    thickness: 7,
                    thumbVisibility: true,
                    child: ListView.builder(
                      itemCount: rows.length,
                      itemBuilder: (context, idx) {
                        final r = rows[idx];
                        return Table(
                          columnWidths: const {
                            0: FixedColumnWidth(100),
                            1: FlexColumnWidth(),
                            2: FixedColumnWidth(120),
                            3: FixedColumnWidth(90),
                            4: FixedColumnWidth(120),
                          },
                          children: [
                            TableRow(
                              children: [
                                _rowCell(r[0].toString()),
                                _rowCell(r[1].toString()),
                                _rowCell(r[2].toString()),
                                _rowCell(r[3].toString()),
                                Center(child: SizedBox(
                                  width: 90, height: 33, // Fixed status button size
                                  child: r[4] as Widget
                                )),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
  static Widget _headerCell(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: Text(text, style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Color(0xFF5A6474), fontSize: 15, letterSpacing: 0.05)),
      );
  static Widget _rowCell(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(text, style: GoogleFonts.inter(fontSize: 15, color: Color(0xFF222B45))),
      );
  static Widget _statusTag(String label, Color? bgColor, Color? txtColor) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: txtColor, fontSize: 13, letterSpacing: 0.2),
        ),
      );
}

// -------------------- Quick Actions Section --------------------
class QuickActionsCard extends StatelessWidget {
  final VoidCallback openAddAppointment;
  const QuickActionsCard({required this.openAddAppointment, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          QuickActionButton(icon: Icons.add, text: 'New Appointments', onTap: openAddAppointment),
          const SizedBox(height: 10),
          QuickActionButton(icon: Icons.person_add_alt_1, text: 'New Patient', onTap: () {}),
          const SizedBox(height: 10),
          QuickActionButton(icon: Icons.note_add_outlined, text: 'Certificates & Notes', onTap: () {}),
        ],
      ),
    );
  }
}
class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const QuickActionButton({super.key, required this.icon, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 19, color: Color(0xFF2F2F2F)),
        label: Text(text, style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Color(0xFF2F2F2F), fontSize: 14)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 13),
          backgroundColor: const Color(0xFFF7F8FA),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: const BorderSide(color: Color(0xFFEFEFEF)),
        ),
      ),
    );
  }
}

// ------------ End of dashboard code ------------

