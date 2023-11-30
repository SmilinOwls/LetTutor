import 'package:flutter/material.dart';

class HelperText extends StatelessWidget {
  const HelperText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.3),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.8),
        ),
      ),
      child: Text(text),
    );
  }
}
