import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/features/schedule/widgets/schedule_cancel_dialog.dart';
import 'package:lettutor/features/schedule/widgets/schedule_request_dialog.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  Future<void> _showScheduleCancelingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return const ScheduleCancelingDialog();
        });
  }

  Future<void> _showScheduleRequestingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return const SchduleRequestDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              DateFormat.yMMMEd().format(DateTime.now()),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 4),
            const Text('1 lesson'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  const Icon(Icons.person_outline_rounded,
                                      size: 62),
                            ),
                          ))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Keegan',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'French',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    '18:30 - 18:55',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  ExpansionTile(
                    title: const Text(
                      'Request for lesson',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        _showScheduleRequestingDialog(context);
                      },
                      child: const Text('Edit request',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          )),
                    ),
                    initiallyExpanded: true,
                    controlAffinity: ListTileControlAffinity.leading,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                    collapsedShape: const RoundedRectangleBorder(
                      side: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                    children: const <Widget>[
                      ListTile(
                        title: Text(
                          'Currently there are no requests for this class. Please write down any requests for the teacher.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                OutlinedButton.icon(
                  onPressed: () {
                    _showScheduleCancelingDialog(context);
                  },
                  icon: const Icon(Icons.cancel_presentation_outlined),
                  label: const Text(
                    'Cancel',
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text(
                    'Go to meeting',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
