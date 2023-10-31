import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LessonDialog extends StatelessWidget {
  const LessonDialog({super.key, this.child, this.onSubmit});

  final Widget? child;
  final void Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: Container(
                width: 62,
                height: 62,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/avatar/user/user_avatar.jpeg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person_outline_rounded, size: 62),
                  ),
                ),
              ),
            ),
            Text(
              'Keegan',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            const Text('Lesson Time', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 2),
            Text(
              '${DateFormat.yMMMEd().format(DateTime.now())}, 18:30 - 18:55',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 14),
            const Divider(height: 1),
            child!
          ],
        ),
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            side: const BorderSide(color: Colors.blue),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: const Text(
            'Later',
          ),
        ),
        TextButton(
          onPressed: () {
            onSubmit;
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue[700],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
