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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final sidebarWidth = isMobile ? constraints.maxWidth : 260.0;
        final fontSize = isMobile ? 14.0 : 20.0;
        final profileRadius = isMobile ? 28.0 : 36.0;

        return Material(
          elevation: 6,
          child: Container(
            width: sidebarWidth,
            height: double.infinity,
            color: const Color(0xFFF2F2F2),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: isMobile ? 16 : 24),

                  // ================= BRAND =================
                  Text(
                    'LiveSure',
                    style: GoogleFonts.inter(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF222B45),
                    ),
                  ),

                  SizedBox(height: isMobile ? 8 : 10),

                  // ================= PROFILE =================
                  CircleAvatar(
                    radius: profileRadius,
                    backgroundImage: const NetworkImage(
                      'https://i.pravatar.cc/150?img=1',
                    ),
                  ),

                  SizedBox(height: isMobile ? 8 : 12),

                  Text(
                    'Dr. Srujitha Koduri',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF222B45),
                    ),
                  ),

                  SizedBox(height: isMobile ? 2 : 4),

                  Text(
                    'General Practitioner',
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 10 : 11,
                      color: const Color(0xFF5A6474),
                    ),
                  ),

                  SizedBox(height: isMobile ? 1 : 2),

                  Text(
                    'DID: **********',
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 10 : 11,
                      color: const Color(0xFF5A6474),
                    ),
                  ),

                  SizedBox(height: isMobile ? 12 : 16),

                  // ================= DIVIDER =================
                  Container(
                    height: 1,
                    width: isMobile ? constraints.maxWidth * 0.7 : 180,
                    color: const Color(0xFFE0E0E0),
                  ),

                  SizedBox(height: isMobile ? 12 : 16),

                  // ================= MENU =================
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 12 : 16,
                    ),
                    child: Column(
                      children: [
                        _NavItem(
                          icon: Icons.dashboard_rounded,
                          title: 'Dashboard',
                          isSelected: selectedItem == 'Dashboard',
                          onTap: () => onSelectItem('Dashboard'),
                          isMobile: isMobile,
                        ),
                        _NavItem(
                          icon: Icons.people_alt_outlined,
                          title: 'Patients',
                          isSelected: selectedItem == 'Patients',
                          onTap: () => onSelectItem('Patients'),
                          isMobile: isMobile,
                        ),
                        _NavItem(
                          icon: Icons.calendar_today_outlined,
                          title: 'Appointments',
                          isSelected: selectedItem == 'Appointments',
                          onTap: () => onSelectItem('Appointments'),
                          isMobile: isMobile,
                        ),
                        _NavItem(
                          icon: Icons.description_outlined,
                          title: 'Prescription',
                          isSelected: selectedItem == 'Prescription',
                          onTap: () => onSelectItem('Prescription'),
                          isMobile: isMobile,
                        ),
                        _NavItem(
                          icon: Icons.message_outlined,
                          title: 'Messages',
                          isSelected: selectedItem == 'Messages',
                          onTap: () => onSelectItem('Messages'),
                          isMobile: isMobile,
                        ),
                        _NavItem(
                          icon: Icons.attach_money_rounded,
                          title: 'Billing',
                          isSelected: selectedItem == 'Billing',
                          onTap: () => onSelectItem('Billing'),
                          isMobile: isMobile,
                        ),
                        _NavItem(
                          icon: Icons.settings_outlined,
                          title: 'Settings',
                          isSelected: selectedItem == 'Settings',
                          onTap: () => onSelectItem('Settings'),
                          isMobile: isMobile,
                        ),
                      ],
                    ),
                  ),

                  // ================= PUSH LOGOUT TO BOTTOM =================
                  SizedBox(height: isMobile ? 16 : 24),

                  Container(
                    height: 1,
                    width: isMobile ? constraints.maxWidth * 0.7 : 180,
                    color: const Color(0xFFE0E0E0),
                  ),

                  SizedBox(height: isMobile ? 12 : 16),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 12 : 16,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF222B45),
                          padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 10 : 12,
                            horizontal: isMobile ? 8 : 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: isMobile ? 16 : 18,
                        ),
                        label: Text(
                          'Logout',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 11 : 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        onPressed: () {
                          // logout logic
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: isMobile ? 12 : 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isMobile;

  const _NavItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.isMobile = false,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isSelected || _hovered;
    final fontSize = widget.isMobile ? 12.0 : 14.0;
    final iconSize = widget.isMobile ? 18.0 : 20.0;
    final padding = widget.isMobile
        ? const EdgeInsets.symmetric(horizontal: 12, vertical: 10)
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 12);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: padding,
          decoration: BoxDecoration(
            color: active ? const Color(0xFFD6E6FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: iconSize,
                color: active
                    ? const Color(0xFF0052CC)
                    : const Color(0xFF5A6474),
              ),
              if (!widget.isMobile) const SizedBox(width: 12),
              if (!widget.isMobile)
                Expanded(
                  child: Text(
                    widget.title,
                    style: GoogleFonts.inter(
                      fontSize: fontSize,
                      fontWeight: widget.isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: active
                          ? const Color(0xFF0052CC)
                          : const Color(0xFF222B45),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              else if (widget.isMobile)
                Tooltip(
                  message: widget.title,
                  child: Text(
                    widget.title,
                    style: GoogleFonts.inter(
                      fontSize: fontSize,
                      fontWeight: widget.isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: active
                          ? const Color(0xFF0052CC)
                          : const Color(0xFF222B45),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
