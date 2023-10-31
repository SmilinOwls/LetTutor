import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/tutor/tutor_book/widgets/tutor_booking_confirm_dialog.dart';

class TutorBookingHourDialog extends StatefulWidget {
  const TutorBookingHourDialog({super.key, required this.date});

  final DateTime date;

  @override
  State<TutorBookingHourDialog> createState() => _TutorBookingHourDialogState();
}

class _TutorBookingHourDialogState extends State<TutorBookingHourDialog> {
  Future<void> _showTutorBookingConfirmDialog(String hour) async {
    final Map<String, dynamic> schedule = {
      'date': widget.date,
      'hour': hour,
    };

    await showDialog(
      context: context,
      builder: (context) => TutorBookingConfirmDialog(schedule: schedule),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          children: [
            Text(
              'Choose Learning Hour',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 6),
            Text(
              'On ${DateFormat('yyyy-MM-dd').format(widget.date)}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 12),
            Flexible(
              fit: FlexFit.tight,
              child: GridView.builder(
                  itemCount: tutorBookingHours.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 28,
                    childAspectRatio: 4,
                  ),
                  itemBuilder: (BuildContext context, int index) =>
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[300],
                        ),
                        onPressed: () {
                          _showTutorBookingConfirmDialog(
                              tutorBookingHours[index]);
                        },
                        child: Text(
                          tutorBookingHours[index],
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      )),
            ),
          ],
        ));
  }
}
