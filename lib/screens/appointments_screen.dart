import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/sidebar.dart';
import '../widgets/add_appointment_popup.dart';

// ================= COLUMN FLEX CONTRACT =================
const int patientFlex = 4;
const int contactFlex = 3;
const int typeFlex = 2;
const int slotFlex = 2;
const int modeFlex = 2;
const int statusFlex = 2;
const int actionFlex = 4;

class AppointmentsScreen extends StatefulWidget {
  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  String selectedTab = 'All';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final allAppointments = [
    {
      'name': 'Emily Davis',
      'id': 'PAT - 001',
      'ageGenderBlood': '33/F | B+ve',
      'contact': '+1-555-0123',
      'email': 'emily.davis@email.com',
      'appointmentType': 'Regular Check-up',
      'slot': '14/08/2025 | 10:00 AM',
      'mode': 'In-person',
      'status': 'Scheduled',
      'actions': ['view', 'reschedule', 'cancel'],
      'avatar': 'assets/profile.png',
    },
    {
      'name': 'John Smith',
      'id': 'PAT - 102',
      'ageGenderBlood': '43/M | AB+ve',
      'contact': '+1-555-0123',
      'email': 'john.smith@email.com',
      'appointmentType': 'Follow-up',
      'slot': '14/08/2025 | 10:30 AM',
      'mode': 'Video call',
      'status': 'Pending',
      'actions': ['view', 'schedule', 'cancel'],
      'avatar': 'assets/profile.png',
    },
    {
      'name': 'Riya Sharma',
      'id': 'PAT - 011',
      'ageGenderBlood': '42/F | A+ve',
      'contact': '+1-555-0123',
      'email': 'riya.sharma@email.com',
      'appointmentType': 'Consultation',
      'slot': '14/08/2025 | 09:00 AM',
      'mode': 'Video call',
      'status': 'Completed',
      'actions': ['view', 'summary'],
      'avatar': 'assets/profile.png',
    },
  ];

  List<Map<String, dynamic>> get filteredAppointments {
    if (selectedTab == 'All') return allAppointments;
    return allAppointments
        .where(
          (a) => a['status'].toString().toLowerCase().contains(
            selectedTab.toLowerCase(),
          ),
        )
        .toList();
  }

  void _showScheduleAppointmentDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => const AddAppointmentPopup());
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['All', 'Pending', 'Upcoming', 'Completed', 'Cancelled'];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: SideBar(
          selectedItem: "Appointments",
          onSelectItem: (item) {
            Navigator.pop(context);
          },
          onClose: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // ================= HEADER BAR =================
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 36),
            color: Colors.white,
            child: Row(
              children: [
                // Hamburger menu (small screens)
                if (MediaQuery.of(context).size.width <= 900)
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        size: 28,
                        color: Color(0xFF222B45),
                      ),
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                  ),

                // Title
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Appointments',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 27,
                        color: Color(0xFF222B45),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Right-side icons
                const Icon(
                  Icons.nightlight_round,
                  size: 26,
                  color: Color(0xFFB2B2B2),
                ),
                const SizedBox(width: 22),
                const Icon(
                  Icons.notifications_none,
                  size: 26,
                  color: Color(0xFFB2B2B2),
                ),
                const SizedBox(width: 22),

                // Profile
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      backgroundImage: const AssetImage("assets/profile.png"),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Dr. Srujitha Koduri",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Color(0xFF222B45),
                          ),
                        ),
                        Text(
                          'General Practitioner',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF5c757D),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ================= TABS =================
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 36, top: 16, bottom: 2),
            child: Row(
              children: tabs.map((tab) {
                final isSelected = selectedTab == tab;
                int count = 0;

                if (tab != 'All') {
                  count = allAppointments.where((app) {
                    final status = app['status'].toString().toLowerCase();
                    switch (tab) {
                      case 'Pending':
                        return status == 'pending';
                      case 'Upcoming':
                        return ['scheduled', 'ongoing'].contains(status);
                      case 'Completed':
                        return status == 'completed';
                      case 'Cancelled':
                        return status == 'cancelled';
                      default:
                        return false;
                    }
                  }).length;
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ChoiceChip(
                    label: Text(
                      tab + (tab == "All" ? "" : " ($count)"),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: isSelected
                            ? const Color(0xFF297EFF)
                            : Colors.black38,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: const Color(0xFFE3EBFA),
                    backgroundColor: const Color(0xFFF8F9FD),
                    shape: const StadiumBorder(),
                    onSelected: (_) {
                      setState(() {
                        selectedTab = tab;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // ================= SEARCH + ACTION =================
          Padding(
            padding: const EdgeInsets.fromLTRB(36, 16, 36, 10),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.275,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search...",
                      hintStyle: TextStyle(fontSize: 12),
                      prefixIcon: Icon(Icons.search, color: Color(0xFFB0B0B0)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_alt_outlined),
                  label: const Text("Filter"),
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(color: Color(0xFFEAEFF5)),
                    foregroundColor: const Color(0xFF222B45),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _showScheduleAppointmentDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF297EFF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "+ Schedule Appointment",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          //),
          // Appointments table - fills remaining space
          Expanded(child: _appointmentsTable()),
        ],
      ),
    );
  }

  // ================= TABLE =================
  Widget _appointmentsTable() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FD),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          children: [
            // HEADER
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: const [
                  _TableHeaderCell("Patient", flex: patientFlex),
                  _TableHeaderCell("Contact", flex: contactFlex),
                  _TableHeaderCell("Type", flex: typeFlex),
                  _TableHeaderCell("Slot", flex: slotFlex),
                  _TableHeaderCell("Mode", flex: modeFlex),
                  _TableHeaderCell("Status", flex: statusFlex),
                  _TableHeaderCell("Actions", flex: actionFlex),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                children: filteredAppointments
                    .map((app) => _appointmentRow(app))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= ROW =================
  Widget _appointmentRow(Map<String, dynamic> app) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // PATIENT
          Expanded(
            flex: patientFlex,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(app['avatar']),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app['name'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "ID: ${app['id']} • ${app['ageGenderBlood']}",
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          _TableCell(
            flex: contactFlex,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(app['contact'], style: const TextStyle(fontSize: 11)),
                Text(
                  app['email'],
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          _TableCell(
            flex: typeFlex,
            child: Text(
              app['appointmentType'],
              style: const TextStyle(fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _TableCell(
            flex: slotFlex,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  app['slot'].toString().split('|')[0].trim(), // DATE
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  app['slot'].toString().split('|')[1].trim(), // TIME
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          _TableCell(
            flex: modeFlex,
            child: Text(app['mode'], style: const TextStyle(fontSize: 11)),
          ),

          _TableCell(
            flex: statusFlex,
            child: Text(
              app['status'],
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _statusColor(app['status']),
              ),
            ),
          ),

          Expanded(
            flex: actionFlex,
            child: Row(
              children: app['actions']
                  .map<Widget>(
                    (a) => Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text(
                        a,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF297EFF),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'scheduled':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

// ================= SHARED CELLS =================

class _TableHeaderCell extends StatelessWidget {
  final String title;
  final int flex;

  const _TableHeaderCell(this.title, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF222B45),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final int flex;
  final Widget child;

  const _TableCell({required this.flex, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Align(alignment: Alignment.center, child: child),
      ),
    );
  }
}
