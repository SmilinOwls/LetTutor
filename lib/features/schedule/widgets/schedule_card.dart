import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/schedule/widgets/schedule_cancel_dialog.dart';
import 'package:lettutor/features/schedule/widgets/schedule_request_dialog.dart';
import 'package:lettutor/features/video_call/video_call_screen.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/models/schedule/schedule_info.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/utils/time_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({
    super.key,
    required this.booking,
    this.onCancel,
  });
  final Function(BookingInfo)? onCancel;
  final BookingInfo booking;

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  late AppLocalizations _local;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
  }

  Future<void> _showScheduleCancelingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return ScheduleCancelingDialog(booking: widget.booking);
        }).then((value) {
      if (value is String) {
        if (value.toLowerCase() == 'true') {
          widget.onCancel?.call(widget.booking);
          SnackBarHelper.showSuccessSnackBar(
              context: context, content: _local.successCancelLesson);
        } else {
          SnackBarHelper.showErrorSnackBar(
              context: context, content: _local.failCancelLesson);
        }
      }
    });
  }

  Future<void> _showScheduleRequestingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return SchduleRequestDialog(
            booking: widget.booking,
            updateStudentRequest: _updateStudentRequest,
          );
        });
  }

  void _updateStudentRequest(String request) {
    setState(() {
      widget.booking.studentRequest = request;
    });
  }

  bool _checkAvailableToJoinSchedule(ScheduleInfo? scheduleInfo) {
    final DateTime now = DateTime.now();
    final DateTime startTime =
        DateTime.fromMillisecondsSinceEpoch(scheduleInfo?.startTimeStamp ?? 0);
    if (now.isBefore(startTime)) {
      return true;
    } else {
      return false;
    }
  }

  bool _checkCancelBeforeLessonStartTwoHours(ScheduleInfo? scheduleInfo) {
    final DateTime now = DateTime.now();
    final DateTime startTime =
        DateTime.fromMillisecondsSinceEpoch(scheduleInfo?.startTimeStamp ?? 0);
    final int diff = startTime.difference(now).inHours;
    if (diff < 2) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScheduleInfo? scheduleInfo =
        widget.booking.scheduleDetailInfo?.scheduleInfo;

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              TimeHelper.convertTimeStampToDate(
                  scheduleInfo?.startTimeStamp ?? 0),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 4),
            Text(_local.numberOfLessons(1)),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${TimeHelper.convertTimeStampToHour(scheduleInfo?.startTimeStamp ?? 0)}'
                    ' - '
                    '${TimeHelper.convertTimeStampToHour(scheduleInfo?.endTimeStamp ?? 0)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ExpansionTile(
                    title: Text(
                      _local.requestForLesson,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        _showScheduleRequestingDialog(context);
                      },
                      child: Text(
                        _local.editRequest,
                        style: const TextStyle(
                          fontSize: 15,
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
                              _local.noRequestForClass,
                          style: const TextStyle(
                            fontSize: 14,
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
                _checkCancelBeforeLessonStartTwoHours(scheduleInfo)
                    ? OutlinedButton.icon(
                        onPressed: () {
                          _showScheduleCancelingDialog(context);
                        },
                        icon: const Icon(Icons.cancel_presentation_outlined),
                        label: Text(_local.cancel),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: _checkAvailableToJoinSchedule(scheduleInfo)
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VideoCallScreen(
                                bookingInfo: widget.booking,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: TextButton.styleFrom(
                    disabledBackgroundColor: Colors.grey,
                    disabledForegroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Text(
                    _local.goToMeeting,
                    style: const TextStyle(fontSize: 16),
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
