import 'package:agenx/screens/patients_screen.dart';
import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/appointments_screen.dart';
import 'widgets/sidebar.dart';
import 'screens/prescription_screen.dart';
import 'screens/patients_list_screen.dart';

void main() {
  runApp(LiveSureApp());
}

class LiveSureApp extends StatefulWidget {
  @override
  State<LiveSureApp> createState() => _LiveSureAppState();
}

class _LiveSureAppState extends State<LiveSureApp> {
  String selectedScreen = 'dashboard';
  String? selectedPatientId;

  //bool sidebarOpen = false;

  //void toggleSidebar() {
  //setState(() {
  // sidebarOpen = !sidebarOpen;
  //});
  //}

  void selectScreen(String screen) {
    setState(() {
      selectedScreen = screen;
      // Clear selected patient whenever we navigate away from a patient
      if (screen != 'patient') selectedPatientId = null;
      //sidebarOpen = false;
    });
  }

  void selectPatient(String patientId) {
    setState(() {
      selectedScreen = 'patient';
      selectedPatientId = patientId;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (selectedScreen == 'dashboard') {
      content = DashboardScreen();
    } else if (selectedScreen == 'appointments') {
      content = AppointmentsScreen();
    } else if (selectedScreen == 'patients_list') {
      content = PatientsListScreen(onSelectPatient: selectPatient);
    } else if (selectedScreen == 'patient') {
      content = PatientsScreen(
        patientId: selectedPatientId ?? '',
        onBack: () => selectScreen('patients_list'),
      );
    } else if (selectedScreen == 'prescription') {
      content = PrescriptionScreen();
    } else {
      content = Container(); // In case you add other screens
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LiveSure',
      theme: ThemeData(
        fontFamily: 'Segoe UI',
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: Scaffold(
        body: Row(
          children: [
            // ✅ STATIC SIDEBAR (always visible)
            SidebarWidget(
              onSelectScreen: selectScreen,
              selectedScreen: selectedScreen,
            ),

            // ✅ CONTENT AREA
            Expanded(child: content),
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

  String _selectedTitle() {
    switch (selectedScreen) {
      case 'dashboard':
        return 'Dashboard';
      case 'appointments':
        return 'Appointments';
      // both list and detail should keep sidebar highlighted as Patients
      case 'patients_list':
      case 'patient':
        return 'Patients';
      case 'prescription':
        return 'Prescription';
      case 'messages':
        return 'Messages';
      case 'billing':
        return 'Billing';
      case 'settings':
        return 'Settings';
      default:
        return selectedScreen.isNotEmpty
            ? selectedScreen[0].toUpperCase() + selectedScreen.substring(1)
            : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the centralized SideBar widget so dashboard reflects sidebar design changes
    return SideBar(
      selectedItem: _selectedTitle(),
      onSelectItem: (item) {
        final key = item.toLowerCase();
        if (key == 'logout') {
          // handle logout if needed
          return;
        }
        // Map item titles back to main keys
        switch (key) {
          case 'dashboard':
            onSelectScreen('dashboard');
            break;
          case 'appointments':
            onSelectScreen('appointments');
            break;
          // Open patients list by default when Patients is clicked
          case 'patients':
            onSelectScreen('patients_list');
            break;
          case 'prescription':
            onSelectScreen('prescription');
            break;

          case 'messages':
            onSelectScreen('messages');
            break;
          case 'billing':
            onSelectScreen('billing');
            break;
          case 'settings':
            onSelectScreen('settings');
            break;
          default:
            onSelectScreen(key);
        }
      },
      onClose: () {},
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

  final List<String> patientNames = [
    'John Smith',
    'Emily Davis',
    'Priya Mehta',
  ]; // example
  final List<String> appointmentTypes = [
    'Consultation',
    'Follow-up',
    'Therapy Session',
  ];
  final List<String> appointmentModes = [
    'In-person',
    'Video calling',
    'Phone call',
  ];

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
                Text(
                  'Add New Appointment',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF000000),
                  ),
                ),
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
                            .map(
                              (name) => DropdownMenuItem(
                                value: name,
                                child: Text(name),
                              ),
                            )
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
                                  : 'auto-fetched',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: inputDecoration(
                          'Patient ID',
                          patientId ?? 'auto-fetched',
                        ),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: inputDecoration(
                          'Gender',
                          gender ?? 'auto-fetched',
                        ),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: inputDecoration(
                          'Age',
                          age != null ? age.toString() : 'auto-calculated',
                        ),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: inputDecoration(
                          'Blood Group',
                          bloodGroup ?? 'auto-fetched',
                        ),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: TextFormField(
                        decoration: inputDecoration(
                          'Email',
                          email ?? 'auto-fetched',
                        ),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: TextFormField(
                        decoration: inputDecoration(
                          'Phone Number',
                          phoneNumber ?? 'auto-fetched',
                        ),
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
                                  : 'dd/mm/yyyy',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: DropdownButtonFormField<String>(
                        decoration: inputDecoration('Appointment Type'),
                        items: appointmentTypes
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
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
                                appointmentTime ??
                                TimeOfDay(hour: 9, minute: 0),
                          );
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
                                  : 'hh:mm (auto-generate AM / PM)',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 320,
                      child: DropdownButtonFormField<String>(
                        decoration: inputDecoration('Appointment Mode'),
                        items: appointmentModes
                            .map(
                              (mode) => DropdownMenuItem(
                                value: mode,
                                child: Text(mode),
                              ),
                            )
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 10,
                        ),
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF2F2F2F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFB9D4FF),
                        padding: EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Save logic here
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Add Appointment',
                        style: TextStyle(
                          color: Color(0xFF2F2F2F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
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
