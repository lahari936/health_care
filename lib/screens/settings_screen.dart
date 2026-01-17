import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          color: const Color(0xFFF6F8FB),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top Bar
                _buildTopBar(),

                // Settings Content
                Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 24),
                  child: isMobile
                      ? _buildMobileSettings()
                      : _buildDesktopSettings(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar() {
    return Material(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Text(
              'Settings',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: const Color(0xFF222B45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopSettings() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sidebar Menu
        Container(
          width: 220,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSettingsMenuItem('Profile', true),
              _buildSettingsMenuItem('Notifications', false),
              _buildSettingsMenuItem('Security', false),
              _buildSettingsMenuItem('Preferences', false),
              _buildSettingsMenuItem('Help & Support', false),
            ],
          ),
        ),
        const SizedBox(width: 24),
        // Settings Content
        Expanded(child: _buildSettingsContent()),
      ],
    );
  }

  Widget _buildMobileSettings() {
    return _buildSettingsContent();
  }

  Widget _buildSettingsContent() {
    return Column(
      children: [
        // Profile Settings
        _buildSettingsSection(
          title: 'Profile Information',
          children: [
            _buildSettingsField('Full Name', 'Dr. Srujitha Koduri'),
            _buildSettingsField('Email', 'srujitha@healthcare.com'),
            _buildSettingsField('Phone Number', '+1-555-0123'),
            _buildSettingsField('Specialization', 'General Practitioner'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB9D4FF),
                foregroundColor: const Color(0xFF222B45),
              ),
              child: const Text('Edit Profile'),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Notification Settings
        _buildSettingsSection(
          title: 'Notifications',
          children: [
            _buildToggleSetting('Enable Notifications', notificationsEnabled, (
              value,
            ) {
              setState(() {
                notificationsEnabled = value;
              });
            }),
            const SizedBox(height: 12),
            _buildToggleSetting('Email Notifications', emailNotifications, (
              value,
            ) {
              setState(() {
                emailNotifications = value;
              });
            }),
            const SizedBox(height: 12),
            _buildToggleSetting('SMS Notifications', smsNotifications, (value) {
              setState(() {
                smsNotifications = value;
              });
            }),
          ],
        ),
        const SizedBox(height: 24),

        // Appearance Settings
        _buildSettingsSection(
          title: 'Appearance',
          children: [
            _buildToggleSetting('Dark Mode', darkMode, (value) {
              setState(() {
                darkMode = value;
              });
            }),
          ],
        ),
        const SizedBox(height: 24),

        // Danger Zone
        _buildSettingsSection(
          title: 'Danger Zone',
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.grey.shade800,
              ),
              child: const Text('Change Password'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red,
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF222B45),
            ),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingsField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5A6474),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Color(0xFF222B45)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleSetting(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF222B45)),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFB9D4FF),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsMenuItem(String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFB9D4FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive ? const Color(0xFF222B45) : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
