import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/appointments_screen.dart';
import 'widgets/sidebar.dart';

void main() {
  runApp(LiveSureApp());
}

class LiveSureApp extends StatefulWidget {
  @override
  State<LiveSureApp> createState() => _LiveSureAppState();
}

class _LiveSureAppState extends State<LiveSureApp> {
  String selectedScreen = 'dashboard';
  bool sidebarOpen = false;

  void toggleSidebar() {
    setState(() {
      sidebarOpen = !sidebarOpen;
    });
  }

  void selectScreen(String screen) {
    setState(() {
      selectedScreen = screen;
      sidebarOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (selectedScreen == 'dashboard') {
      // FIXED: ONLY pass onHamburger as per DashboardScreen definition
      content = DashboardScreen();
    } else if (selectedScreen == 'appointments') {
      content = AppointmentsScreen();
    } else {
      content = Container(); // In case you add other screens
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LiveSure',
      theme: ThemeData(
        fontFamily: 'Segoe UI',
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
      ),
      home: Scaffold(
        body: Stack(
          children: [
            content,
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              left: sidebarOpen ? 0 : -250,
              top: 0,
              bottom: 0,
              child: SidebarWidget(
                onSelectScreen: selectScreen,
                selectedScreen: selectedScreen,
              ),
            ),
            // Hamburger button on top left
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: toggleSidebar,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 8)],
                  ),
                  child: const Icon(Icons.menu, size: 28, color: Color(0xFF2F2F2F)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SidebarWidget and AddAppointmentPopup code as in your original code
class SidebarWidget extends StatelessWidget {
  final Function(String) onSelectScreen;
  final String selectedScreen;

  SidebarWidget({required this.onSelectScreen, required this.selectedScreen});

  final sidebarItems = [
    {'icon': Icons.dashboard, 'title': 'Dashboard', 'key': 'dashboard'},
    {'icon': Icons.people, 'title': 'Patients', 'key': 'patients'},
    {'icon': Icons.calendar_today, 'title': 'Appointments', 'key': 'appointments'},
    {'icon': Icons.receipt, 'title': 'Prescription', 'key': 'prescription'},
    {'icon': Icons.message, 'title': 'Messages', 'key': 'messages'},
    {'icon': Icons.attach_money, 'title': 'Billing', 'key': 'billing'},
    {'icon': Icons.settings, 'title': 'Settings', 'key': 'settings'},
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      elevation: 8,
      child: Container(
        width: 250,
        color: const Color(0xFFF5F7FA),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile at the top
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Dr. Srujitha Koduri',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'General Practitioner',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    'DID: **********',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // App name after profile
            const Text(
              'LiveSure',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xFF2F2F2F),
              ),
            ),
            const Divider(),
            // Navigation list
            Expanded(
              child: ListView.builder(
                itemCount: sidebarItems.length,
                itemBuilder: (context, index) {
                  final item = sidebarItems[index];
                  final bool isSelected = selectedScreen == item['key'];
                  return ListTile(
                    leading: Icon(item['icon'] as IconData,
                        color: isSelected ? Colors.blueAccent : Colors.black54),
                    title: Text(
                      item['title'] as String,
                      style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.blueAccent : Colors.black54),
                    ),
                    onTap: () {
                      if (item['key'] == 'dashboard' ||
                          item['key'] == 'appointments') {
                        onSelectScreen(item['key'] as String);
                      }
                    },
                  );
                },
              ),
            ),
            const Divider(),
            // Logout button bottom
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('LogOut', style: TextStyle(color: Colors.redAccent)),
              onTap: () {
                // Logout logic here
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// AddAppointmentPopup class remains as is in your code.
class AddAppointmentPopup extends StatefulWidget {
  @override
  _AddAppointmentPopupState createState() => _AddAppointmentPopupState();
}

class _AddAppointmentPopupState extends State<AddAppointmentPopup> {
  final _formKey = GlobalKey<FormState>();

  String? patientName;
  DateTime? dob;
  String? patientId;
  String? gender;
  int? age;
  String? bloodGroup;
  String? email;
  String? phoneNumber;
  DateTime? scheduleDate;
  String? appointmentType;
  TimeOfDay? appointmentTime;
  String? appointmentMode;

  final List<String> patientNames = ['John Smith', 'Emily Davis', 'Priya Mehta']; // example
  final List<String> appointmentTypes = ['Consultation', 'Follow-up', 'Therapy Session'];
  final List<String> appointmentModes = ['In-person', 'Video calling', 'Phone call'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 700,
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add New Appointment',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF000000))),
                SizedBox(height: 20),
                Wrap(
                  spacing: 20,
                  runSpacing: 15,
                  children: [
                    SizedBox(
                      width: 320,
                      child: DropdownButtonFormField<String>(
                        decoration: inputDecoration('Patient Name'),
                        items: patientNames
                            .map((name) =>
                                DropdownMenuItem(value: name, child: Text(name)))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            patientName = val;
                            patientId = 'PAT - 001';
                            gender = 'F';
                            age = 30;
                            bloodGroup = 'B+ve';
                            email = 'example@email.com';
                            phoneNumber = '+1-555-0123';
                            dob = DateTime(1993, 1, 1);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: dob ?? DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              dob = picked;
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: inputDecoration(
                                'Date of Birth',
                                dob != null
                                    ? "${dob!.day}/${dob!.month}/${dob!.year}"
                                    : 'auto-fetched'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: inputDecoration('Patient ID', patientId ?? 'auto-fetched'),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: inputDecoration('Gender', gender ?? 'auto-fetched'),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: inputDecoration(
                            'Age',
                            age != null ? age.toString() : 'auto-calculated'),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: inputDecoration(
                            'Blood Group', bloodGroup ?? 'auto-fetched'),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: TextFormField(
                        decoration: inputDecoration('Email', email ?? 'auto-fetched'),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: TextFormField(
                        decoration: inputDecoration(
                            'Phone Number', phoneNumber ?? 'auto-fetched'),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: scheduleDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              scheduleDate = picked;
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: inputDecoration(
                                'Schedule Appointment',
                                scheduleDate != null
                                    ? "${scheduleDate!.day}/${scheduleDate!.month}/${scheduleDate!.year}"
                                    : 'dd/mm/yyyy'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: DropdownButtonFormField<String>(
                        decoration: inputDecoration('Appointment Type'),
                        items: appointmentTypes
                            .map((type) =>
                                DropdownMenuItem(value: type, child: Text(type)))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            appointmentType = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: GestureDetector(
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime:
                                  appointmentTime ?? TimeOfDay(hour: 9, minute: 0));
                          if (picked != null) {
                            setState(() {
                              appointmentTime = picked;
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: inputDecoration(
                                'Appointment Time',
                                appointmentTime != null
                                    ? appointmentTime!.format(context)
                                    : 'hh:mm (auto-generate AM / PM)'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: DropdownButtonFormField<String>(
                        decoration: inputDecoration('Appointment Mode'),
                        items: appointmentModes
                            .map((mode) =>
                                DropdownMenuItem(value: mode, child: Text(mode)))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            appointmentMode = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel',
                          style: TextStyle(
                              color: Color(0xFF2F2F2F), fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFB9D4FF),
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Save logic here
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Add Appointment',
                          style: TextStyle(
                              color: Color(0xFF2F2F2F),
                              fontWeight: FontWeight.w600)),
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

  InputDecoration inputDecoration(String label, [String? hint]) {
    return InputDecoration(
      labelText: label,
      labelStyle:
          TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
      hintText: hint,
      hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
      filled: true,
      fillColor: Color(0xFFF4F5F7),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    );
  }
}
