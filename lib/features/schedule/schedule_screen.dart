import 'package:flutter/material.dart';
import 'package:lettutor/features/schedule/widgets/schedule_card.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Icon(Icons.calendar_month_rounded, size: 62),
          const SizedBox(height: 8),
          Text(
            'Schedule',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          const Text('Here is a list of the sessions you have booked'
              'You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours'),
          const SizedBox(height: 4),
          const Divider(height: 1),
          const SizedBox(height: 16),
          ...List<Widget>.generate(
            2,
            (index) => const ScheduleCard(),
          ),
        ],
      ),
    );
  }
}
