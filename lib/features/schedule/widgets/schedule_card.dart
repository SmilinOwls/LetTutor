import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/schedule/widgets/schedule_cancel_dialog.dart';
import 'package:lettutor/features/schedule/widgets/schedule_request_dialog.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/models/schedule/schedule_info.dart';
import 'package:lettutor/utils/time_convert.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({super.key, required this.booking});

  final BookingInfo booking;

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
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
          return SchduleRequestDialog(
              booking: widget.booking, updateStudentRequest: _updateStudentRequest);
        });
  }

  void _updateStudentRequest(String request) {
    setState(() {
      widget.booking.studentRequest = request;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScheduleInfo? scheduleInfo = widget.booking.scheduleDetailInfo?.scheduleInfo;

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              DateFormat.yMMMEd().format(
                DateFormat('yyyy-MM-dd').parse(scheduleInfo?.date ?? ''),
              ),
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
                          scheduleInfo?.tutorInfo
                                  ?.name ??
                              '',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${convertTimeStampToHour(scheduleInfo?.startTimeStamp ?? 0)}'
                    ' - '
                    '${convertTimeStampToHour(scheduleInfo?.endTimeStamp ?? 0)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ExpansionTile(
                    title: const Text(
                      'Request for lesson',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        _showScheduleRequestingDialog(context);
                      },
                      child: const Text(
                        'Edit request',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    initiallyExpanded: true,
                    controlAffinity: ListTileControlAffinity.leading,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                    collapsedShape: const RoundedRectangleBorder(
                      side: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          widget.booking.studentRequest ??
                              'Currently there are no requests for this class. '
                                  'Please write down any requests for the teacher.',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
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
