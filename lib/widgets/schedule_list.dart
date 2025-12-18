import 'package:flutter/material.dart';

class ScheduleList extends StatelessWidget {
  final List<Map<String, dynamic>> schedule = [
    {
      'time': '09:00 AM',
      'name': 'Ethan Carter',
      'type': 'Check-up',
      'mode': 'Online',
      'status': 'Pending',
      'color': Colors.red
    },
    {
      'time': '12:30 PM',
      'name': 'Olivia Bennett',
      'type': 'Follow-up',
      'mode': 'Online',
      'status': 'Completed',
      'color': Colors.grey
    },
    {
      'time': '03:20 PM',
      'name': 'Noah Thompson',
      'type': 'Consultation',
      'mode': 'Physical',
      'status': 'Ongoing',
      'color': Colors.yellow.shade700
    },
    {
      'time': '12:30 PM',
      'name': 'Sophia Clark',
      'type': 'Follow-up',
      'mode': 'Physical',
      'status': 'Scheduled',
      'color': Colors.green
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: schedule.length,
      itemBuilder: (context, index) {
        final item = schedule[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item['time'], style: TextStyle(fontWeight: FontWeight.bold)),
              Text(item['name']),
              Text(item['type']),
              Text(item['mode']),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: item['color'].withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(item['status'],
                    style: TextStyle(color: item['color'], fontWeight: FontWeight.w700)),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
