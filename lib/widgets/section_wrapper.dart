import 'package:flutter/material.dart';

class SectionWrapper extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  const SectionWrapper({required this.child, this.backgroundColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF2596BE),
        borderRadius: BorderRadius.circular(22),
      ),
      child: child,
    );
  }
}
