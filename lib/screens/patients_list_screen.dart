import 'package:flutter/material.dart';
import '../widgets/add_new_patient_dialog.dart';

// ================= COLUMN FLEX CONTRACT =================
const int patientFlex = 2;
const int contactFlex = 3;
const int ageFlex = 1;
const int bloodFlex = 1;
const int visitFlex = 2;
const int billingFlex = 1;
const int upcomingFlex = 2;
const int actionFlex = 3;

class PatientsListScreen extends StatelessWidget {
  final void Function(String) onSelectPatient;

  const PatientsListScreen({Key? key, required this.onSelectPatient})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          color: const Color(0xFFF6F8FB),
          padding: EdgeInsets.all(isMobile ? 12 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context, isMobile),
              const SizedBox(height: 20),
              _patientsCard(),
            ],
          ),
        );
      },
    );
  }

  // ================= HEADER =================
  Widget _header(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Patient Management',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: _newPatientButton(context)),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Patient Management',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        _newPatientButton(context),
      ],
    );
  }

  Widget _newPatientButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const AddNewPatientDialog(),
        );
      },
      icon: const Icon(Icons.person_add_alt_1, size: 18),
      label: const Text('New Patient'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF297EFF),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ================= MAIN CARD =================
  Widget _patientsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _searchAndFilter(),
          const SizedBox(height: 16),
          _tableHeader(),
          const Divider(height: 1),
          _patientRow(id: 'PAT-001', name: 'Emily Davis'),
          _patientRow(id: 'PAT-002', name: 'John Smith'),
          _patientRow(id: 'PAT-003', name: 'Priya Mehta'),
        ],
      ),
    );
  }

  // ================= SEARCH + FILTER =================
  Widget _searchAndFilter() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 520,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Patients...',
                  hintStyle: const TextStyle(fontSize: 12),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: const Color(0xFFF2F4F8),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: 'All Patients',
                    items: const [
                      DropdownMenuItem(
                        value: 'All Patients',
                        child: Text('All Patients'),
                      ),
                    ],
                    onChanged: (_) {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= TABLE HEADER =================
  Widget _tableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: const [
          _HeaderCell('Patient', flex: patientFlex),
          _HeaderCell('Contact', flex: contactFlex),
          _HeaderCell('Age / Gender', flex: ageFlex),
          _HeaderCell('Blood Group', flex: bloodFlex),
          _HeaderCell('Last Visit', flex: visitFlex),
          _HeaderCell('Billing Status', flex: billingFlex),
          _HeaderCell('Upcoming Visit', flex: upcomingFlex),
          _HeaderCell('Quick Actions', flex: actionFlex),
        ],
      ),
    );
  }

  // ================= PATIENT ROW =================
  Widget _patientRow({required String id, required String name}) {
    return InkWell(
      onTap: () => onSelectPatient(id),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFEAEAEA))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // PATIENT
            Expanded(
              flex: patientFlex,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=32',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'ID: $id',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const _TableCell(
              text: '+1-555-0123\nemily.davis@email.com',
              flex: contactFlex,
            ),
            const _TableCell(text: '33 / F', flex: ageFlex),
            const _TableCell(text: 'B+ve', flex: bloodFlex),
            const _TableCell(text: '14/08/2025', flex: visitFlex),
            const _TableCell(text: 'Paid', flex: billingFlex),
            const _TableCell(text: '27/09/2025', flex: upcomingFlex),

            // ACTIONS
            Expanded(
              flex: actionFlex,
              child: Row(
                children: const [
                  _ActionLink('view'),
                  SizedBox(width: 12),
                  _ActionLink('contact'),
                  SizedBox(width: 12),
                  _ActionLink('schedule'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= SMALL WIDGETS =================

class _HeaderCell extends StatelessWidget {
  final String text;
  final int flex;

  const _HeaderCell(this.text, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final int flex;

  const _TableCell({required this.text, required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}

class _ActionLink extends StatelessWidget {
  final String text;

  const _ActionLink(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.blue,
      ),
    );
  }
}
