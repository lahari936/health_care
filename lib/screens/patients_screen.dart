import 'package:flutter/material.dart';

class PatientsScreen extends StatefulWidget {
  final String patientId;
  final VoidCallback onBack;

  const PatientsScreen({
    Key? key,
    required this.patientId,
    required this.onBack,
  }) : super(key: key);

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _historyRevealed = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF6F8FB),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: widget.onBack,
                ),
                const SizedBox(width: 6),
                Text(
                  'Patient Profile',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _patientCard(context),
            const SizedBox(height: 18),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _historyRevealed
                  ? _medicalHistorySection()
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 18),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _historyRevealed
                  ? _recentAppointmentsSection()
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _patientCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileHeader(),
          const SizedBox(height: 14),
          _infoGrid(),
          const SizedBox(height: 20),
          _requestAccessSection(context),
        ],
      ),
    );
  }

  Widget _profileHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 32,
          backgroundImage: AssetImage('assets/images/profile.png'),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Olivia Bennett',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Patient ID: ${widget.patientId}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
                height: 1.1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _infoGrid() {
    final items = [
      _InfoItem(label: 'Date of Birth', value: 'January 15, 1994'),
      _InfoItem(label: 'Gender', value: 'Female'),
      _InfoItem(label: 'Contact', value: '123-4567'),
      _InfoItem(label: 'Last Visit', value: 'March 10, 2024'),
      _InfoItem(label: 'Next Appointment', value: 'April 20, 2024'),
      _InfoItem(label: 'Address', value: '123 Maple Street, USA'),
    ];

    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 16,
      shrinkWrap: true,
      childAspectRatio: 6,
      physics: const NeverScrollableScrollPhysics(),
      children: items,
    );
  }

  Widget _requestAccessSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE3E6ED)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'Request Medical History Access\nTo access Olivia’s medical history, please submit a request.',
              style: TextStyle(fontSize: 14, height: 1.15),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                _historyRevealed = true;
              });

              // wait a frame then scroll to reveal
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOut,
                  );
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C8CFF),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Request Access'),
          ),
        ],
      ),
    );
  }

  Widget _medicalHistorySection() {
    Widget pair(String label, String value) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF4B6A8B),
            fontSize: 14,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontSize: 14, height: 1.1)),
        const SizedBox(height: 12),
        const Divider(height: 1),
        const SizedBox(height: 12),
      ],
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Medical History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pair('Allergies', 'Avocado, Nuts'),
                    pair('Conditions', 'Type 2 Diabetes, Hypertension'),
                    pair('Surgeries', 'Appendectomy'),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pair('Medications', 'Metformin'),
                    pair('Immunizations', 'Up to date'),
                    pair(
                      'Family History',
                      'Father: Heart Disease, Mother: Arthritis',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _recentAppointmentsSection() {
    final rows = [
      ['2024-07-01', '10:00 AM', 'Check-up', 'Dr. Srujitha'],
      ['2024-06-15', '02:30 PM', 'Consultation', 'Dr. Srujitha'],
      ['2024-05-20', '11:00 AM', 'Follow-up', 'Dr. Srujitha'],
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Appointments',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(color: Color(0xFFF4F8FB)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Date',
                      style: TextStyle(color: Colors.grey[700], height: 1.1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Time',
                      style: TextStyle(color: Colors.grey[700], height: 1.1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Type',
                      style: TextStyle(color: Colors.grey[700], height: 1.1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Provider',
                      style: TextStyle(color: Colors.grey[700], height: 1.1),
                    ),
                  ),
                ],
              ),
              for (var r in rows)
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(r[0], style: const TextStyle(height: 1.1)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(r[1], style: const TextStyle(height: 1.1)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        r[2],
                        style: const TextStyle(
                          color: Color(0xFF2F66A8),
                          height: 1.1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(r[3], style: const TextStyle(height: 1.1)),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              height: 1.1,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.1,
            ),
          ),
        ),
      ],
    );
  }
}
