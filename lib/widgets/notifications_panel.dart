import 'package:flutter/material.dart';

class NotificationsPanel extends StatelessWidget {
  final List<String> notifications = [
    'No recent notification',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Text(
            notifications[index],
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
        );
      },
    );
  }
}