import 'package:flutter/material.dart';
import '../widgets/add_new_patient_dialog.dart';

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
              SizedBox(height: isMobile ? 12 : 20),
              _patientsCard(isMobile: isMobile),
            ],
          ),
        );
      },
    );
  }

  // ================= HEADER =================
  Widget _header(BuildContext context, bool isMobile) {
    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Patient Management',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const AddNewPatientDialog(),
                    );
                  },
                  icon: const Icon(Icons.person_add_alt_1, size: 16),
                  label: const Text('New Patient'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8EBF2),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Patient Management',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              ElevatedButton.icon(
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
                  backgroundColor: const Color(0xFFE8EBF2),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          );
  }

  // ================= MAIN CARD =================
  Widget _patientsCard({bool isMobile = false}) {
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

  // ================= SEARCH =================
  Widget _searchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search Patients...',
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F4F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
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
      ],
    );
  }

  // ================= TABLE HEADER =================
  Widget _tableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: const [
          _HeaderCell('Patient', flex: 3),
          _HeaderCell('Contact', flex: 2),
          _HeaderCell('Age / Gender'),
          _HeaderCell('Blood Group'),
          _HeaderCell('Last Visit'),
          _HeaderCell('Billing Status'),
          _HeaderCell('Upcoming Visit'),
          _HeaderCell('Quick Actions', flex: 2),
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
          children: [
            // Patient
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
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
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'ID: $id',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Contact
            const _Cell(text: '+1-555-0123\nemily.davis@email.com'),

            const _Cell(text: '33 / F'),
            const _Cell(text: 'B+ve'),
            const _Cell(text: '14/08/2025'),
            const _Cell(text: 'Paid'),
            const _Cell(text: '27/09/2025'),

            // Actions
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => onSelectPatient(id),
                    child: const _ActionLink('view'),
                  ),
                  const SizedBox(width: 10),
                  const _ActionLink('contact'),
                  const SizedBox(width: 10),
                  const _ActionLink('schedule'),
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

  const _HeaderCell(this.text, {this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final String text;

  const _Cell({required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(text, style: const TextStyle(fontSize: 13)));
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
