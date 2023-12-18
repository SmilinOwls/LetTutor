import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';

class TagChip extends StatelessWidget {
  const TagChip({super.key, required this.tags});

  final List<String?> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 6,
      runSpacing: 8,
      children: List<Widget>.generate(
        tags.length,
        (index) => Chip(
          side: const BorderSide(width: 0, color: Colors.white),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color.fromARGB(255, 221, 234, 255),
          label: Text(
            specialities.where((element) => element.key == tags[index]).isEmpty
                ? tags[index]!
                : specialities
                    .where((element) => element.key == tags[index])
                    .first
                    .name!,
            style: const TextStyle(
                fontSize: 14, color: Color.fromARGB(255, 0, 113, 240)),
          ),
        ),
      ).toList(),
    );
  }
}
