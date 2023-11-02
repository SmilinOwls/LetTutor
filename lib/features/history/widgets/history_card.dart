import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/features/history/widgets/history_rating_dialog.dart';
import 'package:lettutor/features/history/widgets/history_report_dialog.dart';
import 'package:lettutor/utils/time_diff.dart';
import 'package:lettutor/widgets/star_rating.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({super.key});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  final List<String> _skillRating = <String>[
    'Behavior',
    'Listening',
    'Speaking',
    'Vocabulary'
  ];

  double? _rating;

  Future<void> _showHistoryReportDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return const HistoryReportDialog();
        });
  }

  Future<void> _showHistoryRatingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return const HistoryRatingDialog();
        }).then((value) {
      if (value != null) {
        setState(() {
          _rating = value;
        });
      }
    });
  }

  Widget buildSkillRating(BuildContext context, int index) {
    return Row(
      children: [
        Text(_skillRating[index]),
        const Text(' ('),
        const StarRating(rating: 5),
        const Text('): '),
        const Text('Great')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      color: const Color.fromARGB(255, 241, 241, 241),
      elevation: 0,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              DateFormat.yMMMEd().format(DateTime.now()),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 4),
            Text(
              TimeDiff.timeAgo('2023-10-30 00:00'),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.white,
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
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: const Text(
                'Lesson Time: 19:30-19:55',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const ExpansionTile(
                    title: Text(
                      'Request for lesson',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    shape: RoundedRectangleBorder(),
                    children: [
                      ListTile(
                        title: Text(
                          'Need to have more exercises',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 1),
                  ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                    childrenPadding: const EdgeInsets.only(
                      left: 14,
                      bottom: 10,
                    ),
                    title: const Text(
                      'Review from tutor',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    shape: const RoundedRectangleBorder(),
                    children: [
                      const Text(
                        'Session 1: 00:00 - 00:25',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text('Level status: Completed'),
                      ...List<Widget>.generate(
                        _skillRating.length,
                        (index) => buildSkillRating(context, index),
                      ),
                      const Text('Overall comment: Good'),
                    ],
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: _rating != null
                              ? Row(
                                  children: <Widget>[
                                    const Text('Rating: '),
                                    StarRating(
                                      rating: _rating!,
                                      onRatingChanged: (value) {},
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                        InkWell(
                          onTap: () {
                            _showHistoryRatingDialog(context);
                          },
                          child: Text(
                            _rating != null ? 'Edit' : 'Add a rating',
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            _showHistoryReportDialog(context);
                          },
                          child: const Text(
                            'Report',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
