import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/features/tutor/tutor_book/widgets/tutor_booking_hour_dialog.dart';
import 'package:lettutor/widgets/app_bar.dart';

class TutorBookingScreen extends StatefulWidget {
  const TutorBookingScreen({super.key});

  @override
  State<TutorBookingScreen> createState() => _TutorBookingScreenState();
}

class _TutorBookingScreenState extends State<TutorBookingScreen> {
  final scheduledStartingDate = getDaysInBetween(
      DateTime.now(), DateTime.utc(DateTime.now().year + 1, 1, 0));

  Future<void> _showTutorBookingTimeDialog(DateTime date) async {
    await showModalBottomSheet(
      elevation: 3,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      builder: (context) => TutorBookingHourDialog(date: date),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarLeading: true,
        appBarTitle: 'Tutor Booking',
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'Choose Learning Date',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Flexible(
              fit: FlexFit.tight,
              child: GridView.builder(
                itemCount: scheduledStartingDate.length,
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
                    _showTutorBookingTimeDialog(scheduledStartingDate[index]);
                  },
                  child: Text(
                    DateFormat('yyyy-MM-dd')
                        .format(scheduledStartingDate[index]),
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(DateTime(startDate.year, startDate.month, startDate.day + i));
  }
  return days;
}
