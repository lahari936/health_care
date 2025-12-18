import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideBar extends StatelessWidget {
  final String selectedItem;
  final Function(String) onSelectItem;
  final bool isVisible;
  final VoidCallback onClose;

  const SideBar({
    Key? key,
    required this.selectedItem,
    required this.onSelectItem,
    required this.isVisible,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      left: isVisible ? 0 : -270,
      top: 0,
      bottom: 0,
      child: Material(
        elevation: 8,
        child: Container(
          width: 250,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              if (MediaQuery.of(context).size.width < 800)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Color(0xFF5A6474)),
                    onPressed: onClose,
                    tooltip: 'Close',
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Dr. Srujitha Koduri',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF222B45))),
                    Text(
                      'General Practitioner',
                      style: GoogleFonts.inter(color: Color(0xFF0C89E4), fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'DID: **********',
                      style: GoogleFonts.inter(color: Color(0xFF0C89E4), fontSize: 11, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(height: 1, color: const Color(0xFFE6E8EC), margin: const EdgeInsets.symmetric(horizontal: 24)),
              const SizedBox(height: 8),
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
                icon: Icons.description_outlined,
                title: 'Prescription',
                isSelected: selectedItem == 'Prescription',
                onTap: () => onSelectItem('Prescription'),
              ),
              _NavItem(
                icon: Icons.calendar_today_outlined,
                title: 'Appointments',
                isSelected: selectedItem == 'Appointments',
                onTap: () => onSelectItem('Appointments'),
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
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 12),
                child: _NavItem(
                  icon: Icons.logout,
                  title: 'LogOut',
                  isSelected: false,
                  onTap: () {/* Logout logic here */},
                  isLogout: true,
                ),
              ),
            ],
          ),
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
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.isSelected || _isHovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isLogout
                ? Colors.transparent
                : isActive
                    ? const Color(0xFFD6E6FF)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: widget.isLogout
                    ? Color(0xFFFF5858)
                    : (isActive ? Color(0xFF0052CC) : Color(0xFF5A6474)),
                size: 21,
              ),
              const SizedBox(width: 12),
              Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.w500,
                  color: widget.isLogout
                      ? Color(0xFFFF5858)
                      : (isActive ? Color(0xFF0052CC) : Color(0xFF222B45)),
                  fontSize: 14,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
