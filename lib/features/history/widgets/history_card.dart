import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/history/widgets/history_rating_dialog.dart';
import 'package:lettutor/features/history/widgets/history_report_dialog.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/models/schedule/schedule_info.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/utils/time_helper.dart';
import 'package:lettutor/widgets/star_rating/star_rating.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard(
      {super.key, required this.booking, required this.onUpdatedBooking});

  final BookingInfo booking;

  final void Function() onUpdatedBooking;

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  // final List<String> _skillRating = <String>[
  //   'Behavior',
  //   'Listening',
  //   'Speaking',
  //   'Vocabulary'
  // ];

  double? _rating;
  @override
  void initState() {
    super.initState();
    _rating = widget.booking.feedbacks?.lastOrNull?.rating?.toDouble();
  }

  Future<void> _showHistoryReportDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return HistoryReportDialog(
            booking: widget.booking,
          );
        }).then((value) {
      if (value != null) {
        SnackBarHelper.showInfoSnackBar(
          context: context,
          content: value,
        );
      }
    });
  }

  Future<void> _showHistoryRatingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return HistoryRatingDialog(
            booking: widget.booking,
            feedback: widget.booking.feedbacks?.lastOrNull,
          );
        }).then((value) {
      if (value != null) {
        widget.onUpdatedBooking();
        setState(() {
          _rating = value;
        });
      }
    });
  }

  // Widget buildSkillRating(BuildContext context, int index) {
  //   return Row(
  //     children: <Widget>[
  //       Text(_skillRating[index]),
  //       const Text(' ('),
  //       const StarRating(rating: 5),
  //       const Text('): '),
  //       const Text('Great')
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final ScheduleInfo? scheduleInfo =
        widget.booking.scheduleDetailInfo?.scheduleInfo;

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              TimeHelper.convertTimeStampToDay(
                scheduleInfo?.startTimeStamp ?? 0,
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 4),
            Text(
              TimeHelper.timeAgo(
                DateTime.fromMillisecondsSinceEpoch(
                  scheduleInfo?.startTimeStamp ?? 0,
                ).toString(),
              ),
            ),
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
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl: scheduleInfo?.tutorInfo?.avatar ?? '',
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.person,
                          size: 62,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          scheduleInfo?.tutorInfo?.name ?? '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          countryList[scheduleInfo?.tutorInfo?.country ?? ''] ??
                              '',
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
              child: Text(
                'Lesson Time: '
                '${TimeHelper.convertTimeStampToHour(scheduleInfo?.startTimeStamp ?? 0)}'
                ' - '
                '${TimeHelper.convertTimeStampToHour(scheduleInfo?.endTimeStamp ?? 0)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  childrenPadding: const EdgeInsets.only(
                    left: 8,
                    bottom: 10,
                  ),
                  title: const Text(
                    'Request for lesson',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  shape: const RoundedRectangleBorder(),
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        widget.booking.studentRequest ??
                            'No request for this lesson',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 1),
                ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  childrenPadding: const EdgeInsets.only(
                    left: 8,
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
                  children: <Widget>[
                    // const Text(
                    //   'Session 1: 00:00 - 00:25',
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    // ),
                    // const Text('Level status: Completed'),
                    // ...List<Widget>.generate(
                    //   _skillRating.length,
                    //   (index) => buildSkillRating(context, index),
                    // ),
                    // const Text('Overall comment: Good'),
                    ListTile(
                      title: Text(
                        widget.booking.tutorReview ??
                            'Tutor has not reviewed yet',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
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
          ],
        ),
      ),
    );
  }
}
