import 'package:flutter/material.dart';
import 'package:agenx/widgets/new_prescription_dialogue.dart';

class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF6F8FB),
      child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= LEFT SECTION =================
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _pageHeader(context),
                    const SizedBox(height: 16),
                    _searchAndFilter(),
                    const SizedBox(height: 16),
                    _prescriptionList(),
                  ],
                ),
              ),

              const SizedBox(width: 24),

              // ================= RIGHT SECTION =================
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _quickActions(context),
                    const SizedBox(height: 24),
                    _recentActivity(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= PAGE HEADER =================
  Widget _pageHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Prescription Management',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const NewPrescriptionDialog(),
            );
          },
          icon: const Icon(Icons.add, size: 18),
          label: const Text('New Prescription'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE8EBF2),
            foregroundColor: Colors.black,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  // ================= SEARCH + FILTER =================
  Widget _searchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Patients...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFF2F4F8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F8),
              borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }

  // ================= PRESCRIPTION LIST =================
  Widget _prescriptionList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: List.generate(6, (index) {
          return _prescriptionTile();
        }),
      ),
    );
  }

  Widget _prescriptionTile() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=47'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Emily Davis',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2),
                Text(
                  'ID: PAT - 001\n33 / F | B+ve',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          _pillButton('view'),
          const SizedBox(width: 8),
          _pillButton('pdf'),
        ],
      ),
    );
  }

  Widget _pillButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  // ================= QUICK ACTIONS =================
  //Widget _quickActions() {
  //  return _rightCard(
  //   title: 'Quick Actions',
  //  child: Column(
  // children: const [
  // _ActionItem('New Prescription'),
  // onPressed: () {
  //showDialog(
  // context: context,
  // barrierDismissible: false,
  // builder: (_) => const NewPrescriptionDialog(),
  // );
  //},

  //_ActionItem('Create Draft'),
  // _ActionItem('Select Template'),
  // ],
  // ),
  //);
  //}

  Widget _quickActions(BuildContext context) {
    return _rightCard(
      title: 'Quick Actions',
      child: Column(
        children: [
          _ActionItem(
            'New Prescription',
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const NewPrescriptionDialog(),
              );
            },
          ),
          _ActionItem('Create Draft', onTap: () {}),
          _ActionItem('Select Template', onTap: () {}),
        ],
      ),
    );
  }

  // ================= RECENT ACTIVITY =================
  Widget _recentActivity() {
    return _rightCard(
      title: 'Recent Activity',
      child: Column(
        children: const [
          _ActivityItem(
            text: 'Prescription sent to Emily Davis',
            color: Colors.green,
          ),
          _ActivityItem(
            text: 'Draft created successfully',
            color: Colors.green,
          ),
          _ActivityItem(text: 'Error to edit draft', color: Colors.red),
          _ActivityItem(
            text: 'Prescription sent to Emily Davis',
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _rightCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

// ================= ACTION ITEM =================
class _ActionItem extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final VoidCallback? onTap;

  const _ActionItem(this.title, {this.onPressed, this.onTap});

  @override
  Widget build(BuildContext context) {
    final action = onPressed ?? onTap;
    return InkWell(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_box_outlined, color: Colors.blue),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}

// ================= ACTIVITY ITEM =================
class _ActivityItem extends StatelessWidget {
  final String text;
  final Color color;

  const _ActivityItem({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
