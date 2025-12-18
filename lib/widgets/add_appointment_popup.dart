import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAppointmentPopup extends StatelessWidget {
  const AddAppointmentPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(18);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: Container(
        width: 640,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Add New Appointment', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF222B45))),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Color(0xFF5A6474)),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
              const SizedBox(height: 18),
              // FORM FIELDS GRID
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _labeltext('Patient Name'),
                        _dropdown(),
                        _labeltext('Patient ID'),
                        _autotext(),
                        _labeltext('Email'),
                        _autotext(),
                        _labeltext('Schedule Appointment'),
                        _datetext(),
                        _labeltext('Appointment Time'),
                        _timetext(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      children: [
                        _labeltext('Date of Birth'),
                        _autotext(),
                        _labeltext('Gender'),
                        _autotext(),
                        _labeltext('Age'),
                        _autotext(),
                        _labeltext('Blood Group'),
                        _autotext(),
                        _labeltext('Phone Number'),
                        _autotext(),
                        _labeltext('Appointment Type'),
                        _dropdown(),
                        _labeltext('Appointment Mode'),
                        _dropdown(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              // BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      side: BorderSide(color: Color(0xFFCED2DA)),
                    ),
                    child: Text('Cancel', style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Color(0xFF222B45))),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF222B45),
                      padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 13),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Add Appointment', style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.white)),
                    onPressed: () {
                      // handle save/create logic
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labeltext(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(text, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF9EA6B7))),
    ),
  );
  Widget _dropdown() => DropdownButtonFormField(
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
    ),
    items: [DropdownMenuItem(child: Text("Select", style: GoogleFonts.inter()), value: null)],
    onChanged: (value) {},
  );
  Widget _autotext() => TextFormField(
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
      // Just grayed out, simulate fetch/calc
      fillColor: Color(0xFFF6F6F6),
      filled: true,
      enabled: false,
      hintText: 'auto-fetched',
      hintStyle: GoogleFonts.inter(color: Color(0xFF9EA6B7))
    ),
  );
  Widget _datetext() => TextFormField(
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
      suffixIcon: Icon(Icons.calendar_today_outlined, color: Color(0xFF9EA6B7), size: 17),
      hintText: 'dd/mm/yyyy',
      hintStyle: GoogleFonts.inter(color: Color(0xFF9EA6B7))
    ),
  );
  Widget _timetext() => TextFormField(
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
      suffixIcon: Icon(Icons.access_time_rounded, color: Color(0xFF9EA6B7), size: 17),
      hintText: 'hh:mm (auto-generate AM / PM)',
      hintStyle: GoogleFonts.inter(color: Color(0xFF9EA6B7))
    ),
  );
}
