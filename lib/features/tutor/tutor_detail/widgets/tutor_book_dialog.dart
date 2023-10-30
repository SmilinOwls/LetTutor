import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TutorBookDialog extends StatefulWidget {
  const TutorBookDialog({super.key});

  @override
  State<TutorBookDialog> createState() => _TutorBookDialogState();
}

class _TutorBookDialogState extends State<TutorBookDialog> {
  final scheduledStartingDate = getDaysInBetween(DateTime.now(),DateTime.utc(DateTime.now().year + 1, 0, 0));

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(
              'Choose Learning Date',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 18,
                crossAxisSpacing: 28,
                childAspectRatio: 2,
                children: List<Widget>.generate(
                  scheduledStartingDate.length,
                  (index) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[300],
                    ),
                    onPressed: () {
                      
                    },
                    child: Text(
                      DateFormat('yyyy-MM-dd').format(
                              scheduledStartingDate[index]),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(
        DateTime(
          startDate.year, 
          startDate.month, 
          startDate.day + i)
      );
    }
    return days;
}