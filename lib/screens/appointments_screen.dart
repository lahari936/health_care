import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/sidebar.dart'; // Correct relative import

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
      'slot': '14/08/2025\nMorning | 10:00 AM',
      'mode': 'In-person',
      'status': 'Scheduled',
      'actions': ['view', 'Reschedule', 'cancel'],
      'avatar': 'assets/profile.png',
    },
    {
      'name': 'John Smith',
      'id': 'PAT - 102',
      'ageGenderBlood': '43/M | AB+ve',
      'contact': '+1-555-0123',
      'email': 'john.smith@email.com',
      'appointmentType': 'Follow-up',
      'slot': '14/08/2025\nMorning | 10:30 AM',
      'mode': 'Video calling',
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
      'slot': '14/08/2025\nMorning | 09:00 AM',
      'mode': 'Video calling',
      'status': 'Completed',
      'actions': ['view', 'view summary'],
      'avatar': 'assets/profile.png',
    },
  ];

  List<Map<String, dynamic>> get filteredAppointments {
    if (selectedTab == 'All') return allAppointments;
    if (selectedTab == 'Pending')
      return allAppointments
          .where((app) => app['status'].toString().toLowerCase() == 'pending')
          .toList();
    if (selectedTab == 'Upcoming')
      return allAppointments
          .where((app) =>
              ["scheduled", "ongoing"].contains(app['status'].toString().toLowerCase()))
          .toList();
    if (selectedTab == 'Completed')
      return allAppointments
          .where((app) => app['status'].toString().toLowerCase() == 'completed')
          .toList();
    if (selectedTab == 'Cancelled')
      return allAppointments
          .where((app) => app['status'].toString().toLowerCase() == 'cancelled')
          .toList();
    return allAppointments;
  }

  void _showScheduleAppointmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        child: Container(
          width: 660,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 40),
          decoration:
              BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add New Appointment",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Color(0xFF222B45),
                        )),
                    IconButton(
                      icon: Icon(Icons.close, size: 28),
                      onPressed: () => Navigator.pop(ctx),
                    )
                  ],
                ),
                SizedBox(height: 26),
                // Row 1
                Row(
                  children: [
                    _input("Patient Name", "patient full name search from list"),
                    Spacer(),
                    _input("Date of Birth", "auto-fetched", icon: Icons.calendar_today),
                  ],
                ),
                SizedBox(height: 14),
                // Row 2
                Row(
                  children: [
                    _input("Patient ID", "auto-fetched"),
                    SizedBox(width: 12),
                    _input("Gender", "auto-fetched"),
                    SizedBox(width: 12),
                    _input("Age", "auto-calculated"),
                    SizedBox(width: 12),
                    _input("Blood Group", "auto-fetched"),
                  ],
                ),
                SizedBox(height: 14),
                // Row 3
                Row(
                  children: [
                    _input("Email", "auto-fetched"),
                    Spacer(),
                    _input("Phone Number", "auto-fetched"),
                  ],
                ),
                SizedBox(height: 14),
                // Row 4
                Row(
                  children: [
                    _input("Schedule Appointment", "dd/mm/yyyy", icon: Icons.calendar_today),
                    Spacer(),
                    _input("Appointment Type", "select from list"),
                  ],
                ),
                SizedBox(height: 14),
                // Row 5
                Row(
                  children: [
                    _input("Appointment Time", "hh:mm (auto-generate AM / PM)", icon: Icons.access_time),
                    Spacer(),
                    _input("Appointment Mode", "select from list"),
                  ],
                ),
                SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 28),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9)),
                        foregroundColor: Color(0xFF222B45),
                        backgroundColor: Color(0xFFF5F7FA),
                      ),
                      onPressed: () => Navigator.pop(ctx),
                      child: Text("Cancel",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        backgroundColor: Color(0xFFEEF1F8),
                        foregroundColor: Color(0xFF222B45),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9)),
                      ),
                      onPressed: () {}, // integrate logic if needed
                      child: Text("Add Appointment",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _input(String label, String hint, {IconData? icon}) {
    return SizedBox(
      width: 225,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF222B45),
                fontSize: 15,
              )),
          SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  color: Color(0xFF929292),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              filled: true,
              fillColor: Color(0xFFF5F7FA),
              suffixIcon: icon != null ? Icon(icon, color: Color(0xFFB0B0B0)) : null,
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
        ],
      ),
    );
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
          //isVisible: true,
          onClose: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // HEADER BAR
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 36),
            color: Colors.white,
            child: Row(
              children: [
                // Hamburger menu only for small screens
                if (MediaQuery.of(context).size.width <= 900)
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: IconButton(
                        icon: Icon(Icons.menu, size: 28, color: Color(0xFF222B45)),
                        onPressed: () => _scaffoldKey.currentState?.openDrawer()),
                  ),
                // CENTERED TITLE & PROFILE INFO
                Expanded(
                  child: Row(
                    children: [
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Appointments',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 27,
                              color: Color(0xFF222B45),
                            )),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                // PROFILE, NIGHT MODE, NOTIF ICONS ON RIGHT
                Icon(Icons.nightlight_round, size: 26, color: Color(0xFFB2B2B2)),
                SizedBox(width: 22),
                Icon(Icons.notifications_none, size: 26, color: Color(0xFFB2B2B2)),
                SizedBox(width: 22),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: AssetImage("assets/profile.png"),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dr. Srujitha Koduri",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Color(0xFF222B45)),
                            ),
                            Text('General Practitioner', style: GoogleFonts.inter(color: Color(0xFF5c757D), fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEEF1F8),
                    foregroundColor: Color(0xFF222B45),
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => _showScheduleAppointmentDialog(context),
                  child: Text("+ Schedule Appointment", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                ),
              ],
            ),
          ),
          // TABS
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 36, top: 16, bottom: 2),
            child: Row(
              children: tabs.map((tab) {
                final isSelected = selectedTab == tab;
                int count = 0;
                if (tab != 'All') {
                  if (tab == 'Pending') count = allAppointments.where((app) => app['status'].toString().toLowerCase() == 'pending').length;
                  if (tab == 'Upcoming') count = allAppointments.where((app) => ["scheduled", "ongoing"].contains(app['status'].toString().toLowerCase())).length;
                  if (tab == 'Completed') count = allAppointments.where((app) => app['status'].toString().toLowerCase() == 'completed').length;
                  if (tab == 'Cancelled') count = allAppointments.where((app) => app['status'].toString().toLowerCase() == 'cancelled').length;
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ChoiceChip(
                    label: Text(
                        tab + (tab == "All" ? "" : " ($count)"),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: isSelected ? Color(0xFF297EFF) : Colors.black38)),
                    selected: isSelected,
                    selectedColor: Color(0xFFE3EBFA),
                    onSelected: (sel) {
                      setState(() {
                        selectedTab = tab;
                      });
                    },
                    backgroundColor: Color(0xFFF8F9FD),
                    shape: StadiumBorder(),
                  ),
                );
              }).toList(),
            ),
          ),
          // Search and filter
          Padding(
            padding: EdgeInsets.only(left: 36, right: 36, top: 16, bottom: 10),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5, // half screen width
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search....",
                      prefixIcon: Icon(Icons.search, color: Color(0xFFB0B0B0)),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(color: Color(0xFFEAEFF5)),
                    foregroundColor: Color(0xFF222B45),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.filter_alt_outlined),
                  label: Text("Filter"),
                ),
              ],
            ),
          ),
          // Appointment Table
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF8F9FD),
                  borderRadius: BorderRadius.circular(32)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          children: [
                            _tableHeader("Patient", 3),
                            _tableHeader("Contact", 2),
                            _tableHeader("Appointment Type", 2),
                            _tableHeader("Slot", 2),
                            _tableHeader("Mode", 2),
                            _tableHeader("Status", 2),
                            _tableHeader("Quick Actions", 3),
                          ],
                        ),
                      ),
                      Divider(height: 1, thickness: 1),
                      ...filteredAppointments.map((app) => Container(
                        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13)),
                        child: Row(
                          children: [
                            // Patient column
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundImage: AssetImage(app['avatar']),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(app['name'],
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      Text("ID: ${app['id']}",
                                          style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                                      Text(app['ageGenderBlood'],
                                          style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Contact column
                            Expanded(
                                flex: 2,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(app['contact'], style: TextStyle(fontSize: 13)),
                                      Text(app['email'],
                                          style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                                    ])),
                            // Appointment Type
                            Expanded(flex: 2, child: Text(app['appointmentType'], style: TextStyle(fontSize: 13))),
                            Expanded(flex: 2, child: Text(app['slot'], style: TextStyle(fontSize: 13))),
                            Expanded(flex: 2, child: Text(app['mode'], style: TextStyle(fontSize: 13))),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  app['status'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: _statusColor(app['status'])),
                                )),
                            Expanded(
                                flex: 3,
                                child: Wrap(
                                  spacing: 9,
                                  children: app['actions'].map<Widget>((action) => GestureDetector(
                                        onTap: () {},
                                        child: Text(action.toString().toLowerCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF297EFF),
                                                fontSize: 13)),
                                      )).toList(),
                                )),
                          ],
                        ),
                      )),
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

  Widget _tableHeader(String title, int flex) => Expanded(
        flex: flex,
        child: Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF222B45), fontSize: 13)),
      );

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange.shade700;
      case 'completed':
        return Colors.green;
      case 'ongoing':
        return Colors.blueGrey;
      case 'cancelled':
        return Colors.grey;
      case 'scheduled':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }
}
