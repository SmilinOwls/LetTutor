import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  const TagChip({super.key, required this.specialties});

  final List<String?> specialties;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: List<Widget>.generate(
        specialties.length,
        (index) => Chip(
          backgroundColor: const Color.fromARGB(255,0, 113, 240),
          label: Text(
            specialties[index] ?? "",
            style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
