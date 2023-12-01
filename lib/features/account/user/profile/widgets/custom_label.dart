import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({super.key, this.isRequired = true, required this.label});

  final bool isRequired;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: isRequired
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
                const Padding(
                  padding: EdgeInsets.all(3),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          : Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}
