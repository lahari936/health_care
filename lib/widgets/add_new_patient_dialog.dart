import 'package:flutter/material.dart';

class AddNewPatientDialog extends StatelessWidget {
  const AddNewPatientDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(40),
      backgroundColor: Colors.transparent,
      child: Container(
        width: 620,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New Patient',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            // Row 1
            _row(
              _input('Full Name', 'patient full name'),
              _input('Date of Birth', 'dd/mm/yyyy', icon: Icons.calendar_today),
            ),

            // Row 2
            _row(
              _input('Email', 'patient email'),
              _input('Age', 'auto-calculated', enabled: false),
              _input('Blood Group', 'patient blood group'),
            ),

            // Row 3
            _row(
              _input('Phone Number', 'patient phone number'),
              _input('Schedule Appointment', 'dd/mm/yyyy',
                  icon: Icons.calendar_today),
            ),

            // Row 4
            _row(
              _dropdown('Gender', ['Male', 'Female', 'Other']),
            ),

            const SizedBox(height: 24),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B7CFF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Add Patient'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= REUSABLE UI =================

  Widget _row(Widget a, [Widget? b, Widget? c]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Expanded(child: a),
          if (b != null) const SizedBox(width: 12),
          if (b != null) Expanded(child: b),
          if (c != null) const SizedBox(width: 12),
          if (c != null) Expanded(child: c),
        ],
      ),
    );
  }

  Widget _input(
    String label,
    String hint, {
    bool enabled = true,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        TextField(
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: icon != null ? Icon(icon, size: 18) : null,
            isDense: true,
            filled: true,
            fillColor: const Color(0xFFF2F2F2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdown(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF2F2F2),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (_) {},
        ),
      ],
    );
  }
}
