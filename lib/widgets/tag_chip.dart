import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  const TagChip({super.key, required this.specialties});

  final List<String?> specialties;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 6,
      runSpacing: 8,
      children: List<Widget>.generate(
        specialties.length,
        (index) => Chip(
          backgroundColor: const Color.fromARGB(255, 221, 234, 255),
          label: Text(
            specialties[index] ?? "",
            style: const TextStyle(
                fontSize: 14, color: Color.fromARGB(255, 0, 113, 240)),
          ),
        ),
      ).toList(),
    );
  }
}
