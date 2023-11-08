import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 28),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
