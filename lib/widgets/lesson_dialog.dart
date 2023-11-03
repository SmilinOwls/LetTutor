import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/widgets/message_dialog.dart';

class LessonDialog extends StatelessWidget {
  const LessonDialog({super.key, this.child, this.onSubmit});

  final Widget? child;
  final String? Function()? onSubmit;

  Future<void> _showSuccessfulMessageDialog(BuildContext context) async {
    final String? message = onSubmit!();
    if (message != null) {
      double? value = double.tryParse(message);
      if (value != null) {
        Navigator.of(context).pop(value);
      } else {
        await showDialog(
            context: context,
            builder: (context) {
              return MessageDialog(message: message);
            });
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 20,
          children: <Widget>[
            Column(
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
              ],
            ),
            const Divider(height: 1),
            child!
          ],
        ),
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
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
            _showSuccessfulMessageDialog(context);
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
