import 'package:flutter/material.dart';
import 'package:lettutor/features/history/widgets/history_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          const Icon(Icons.phone_callback_outlined, size: 62),
          const SizedBox(height: 8),
          Text(
            'History',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          const Text('The following is a list of lessons you have attended\n'
              'You can review the details of the lessons you have attended'),
          const SizedBox(height: 4),
          const Divider(height: 1),
          const SizedBox(height: 16),
          ...List<Widget>.generate(
            2,
            (index) => const HistoryCard(),
          ),
        ],
      ),
    );
  }
}