import 'package:flutter/material.dart';

class NewPrescriptionDialog extends StatelessWidget {
  const NewPrescriptionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(40),
      backgroundColor: Colors.transparent,
      child: Container(
        width: 1100,
        height: 650,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),
            const SizedBox(height: 16),
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 3, child: _leftForm()),
                  const SizedBox(width: 20),
                  Expanded(flex: 2, child: _preview()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'New Prescription',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  // ================= LEFT FORM =================
  Widget _leftForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _card(
            title: 'Patient Information',
            child: Column(
              children: [
                _input('Patient ID'),
                _row(
                  _input('Patient Name'),
                  _input('Date of Birth'),
                ),
                _row(
                  _input('Gender'),
                  _input('Blood Group'),
                  _input('Age'),
                ),
                _textArea('Diagnosis'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _card(
            title: 'Medication',
            action: '+ Add Medication',
            child: Column(
              children: [
                _row(
                  _input('Medication Name'),
                  _input('Form'),
                ),
                _row(
                  _input('Frequency'),
                  _input('Duration'),
                  _input('Dosage'),
                ),
                _textArea('Instructions'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= RIGHT PREVIEW =================
  Widget _preview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Prescription Preview',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Doctor & patient details\n\n'
                'Medicine table preview\n\n'
                'Instructions & follow-up\n\n'
                'Signature',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Send Prescription'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= REUSABLE UI =================
  Widget _card({
    required String title,
    String? action,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              if (action != null)
                Text(action,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _row(Widget a, [Widget? b, Widget? c]) {
    return Row(
      children: [
        Expanded(child: a),
        if (b != null) const SizedBox(width: 12),
        if (b != null) Expanded(child: b),
        if (c != null) const SizedBox(width: 12),
        if (c != null) Expanded(child: c),
      ],
    );
  }

  Widget _input(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _textArea(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        maxLines: 3,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
