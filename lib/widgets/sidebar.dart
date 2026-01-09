import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideBar extends StatelessWidget {
  final String selectedItem;
  final Function(String) onSelectItem;
  final VoidCallback onClose;

  const SideBar({
    super.key,
    required this.selectedItem,
    required this.onSelectItem,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      child: Container(
        width: 260,
        height: double.infinity,
        color: const Color(0xFFF2F2F2), // ✅ REQUIRED BACKGROUND
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            // ================= BRAND =================
            Text(
              'LiveSure',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF222B45),
              ),
            ),

            const SizedBox(height: 10),

            // ================= PROFILE =================
            const CircleAvatar(
              radius: 36,
              backgroundImage:
                  NetworkImage('https://i.pravatar.cc/150?img=1'),
            ),

            const SizedBox(height: 12),

            Text(
              'Dr. Srujitha Koduri',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF222B45),
              ),
            ),

            const SizedBox(height: 4),

            Text(
              'General Practitioner',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: const Color(0xFF5A6474),
              ),
            ),

            const SizedBox(height: 2),

            Text(
              'DID: **********',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: const Color(0xFF5A6474),
              ),
            ),

            const SizedBox(height: 16),

            // ================= DIVIDER =================
            Container(
              height: 1,
              width: 180,
              color: const Color(0xFFE0E0E0),
            ),

            const SizedBox(height: 16),

            // ================= MENU =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _NavItem(
                    icon: Icons.dashboard_rounded,
                    title: 'Dashboard',
                    isSelected: selectedItem == 'Dashboard',
                    onTap: () => onSelectItem('Dashboard'),
                  ),
                  _NavItem(
                    icon: Icons.people_alt_outlined,
                    title: 'Patients',
                    isSelected: selectedItem == 'Patients',
                    onTap: () => onSelectItem('Patients'),
                  ),
                  _NavItem(
                    icon: Icons.calendar_today_outlined,
                    title: 'Appointments',
                    isSelected: selectedItem == 'Appointments',
                    onTap: () => onSelectItem('Appointments'),
                  ),
                  _NavItem(
                    icon: Icons.description_outlined,
                    title: 'Prescription',
                    isSelected: selectedItem == 'Prescription',
                    onTap: () => onSelectItem('Prescription'),
                  ),
                  _NavItem(
                    icon: Icons.message_outlined,
                    title: 'Messages',
                    isSelected: selectedItem == 'Messages',
                    onTap: () => onSelectItem('Messages'),
                  ),
                  _NavItem(
                    icon: Icons.attach_money_rounded,
                    title: 'Billing',
                    isSelected: selectedItem == 'Billing',
                    onTap: () => onSelectItem('Billing'),
                  ),
                  _NavItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    isSelected: selectedItem == 'Settings',
                    onTap: () => onSelectItem('Settings'),
                  ),
                ],
              ),
            ),

            // ================= PUSH LOGOUT TO BOTTOM =================
            const Spacer(),

            Container(
              height: 1,
              width: 180,
              color: const Color(0xFFE0E0E0),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _NavItem(
                icon: Icons.logout,
                title: 'Logout',
                isSelected: false,
                isLogout: true,
                onTap: () => onSelectItem('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isLogout;

  const _NavItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isSelected || _hovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isLogout
                ? Colors.transparent
                : active
                    ? const Color(0xFFD6E6FF)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: widget.isLogout
                    ? const Color(0xFFFF5858)
                    : active
                        ? const Color(0xFF0052CC)
                        : const Color(0xFF5A6474),
              ),
              const SizedBox(width: 12),
              Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight:
                      widget.isSelected ? FontWeight.bold : FontWeight.w500,
                  color: widget.isLogout
                      ? const Color(0xFFFF5858)
                      : active
                          ? const Color(0xFF0052CC)
                          : const Color(0xFF222B45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

