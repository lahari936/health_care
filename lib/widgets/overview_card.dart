import 'package:flutter/material.dart';

class OverviewCard extends StatelessWidget {
  final String title;
  final String mainValue;
  final String subValue1;
  final String subValue2;

  OverviewCard({
    required this.title,
    required this.mainValue,
    required this.subValue1,
    required this.subValue2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 120,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF2F2F2F))),
            Text(mainValue,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                    color: Color(0xFF2F2F2F))),
            Text(subValue1,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
            Text(subValue2,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
          ]),
    );
  }
}
