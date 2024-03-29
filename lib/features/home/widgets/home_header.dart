import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lettutor/features/video_call/video_call_screen.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/models/schedule/schedule_info.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/services/call_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/utils/time_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key, required this.local});

  final AppLocalizations local;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int? _totalCall;
  BookingInfo? _bookingInfo;
  ScheduleInfo? _nextLesson;
  Timer? _timer;
  Duration? _currentTime;
  DateTime _timeStamp = DateTime.now();

  @override
  void initState() {
    super.initState();
    _getMostUpcommingLesson();
    _getTotalCall();
  }

  bool _checkLessonStart() {
    if (_timeStamp.isBefore(DateTime.now())) {
      return false;
    } else {
      return true;
    }
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_currentTime?.inSeconds == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _currentTime = _checkLessonStart()
                ? _timeStamp.difference(DateTime.now())
                : DateTime.now().difference(_timeStamp);
          });
        }
      },
    );
  }

  void _getMostUpcommingLesson() async {
    await BookingService.getTutorNextBookingList(
      onSuccess: (schedules) {
        if (schedules.isEmpty) return;

        schedules.removeWhere(
          (schedule) => DateTime.fromMillisecondsSinceEpoch(
                  schedule.scheduleDetailInfo?.scheduleInfo?.endTimeStamp ??
                      0)
              .isBefore(DateTime.now()),
        );

        schedules.sort((soonSchedule, laterSchedule) {
          final soonScheduleTimeStamp =
              soonSchedule.scheduleDetailInfo?.scheduleInfo?.startTimeStamp ??
                  0;
          final laterScheduleTimeStamp =
              laterSchedule.scheduleDetailInfo?.scheduleInfo?.startTimeStamp ??
                  0;
          return soonScheduleTimeStamp.compareTo(laterScheduleTimeStamp);
        });

        setState(() {
          _bookingInfo = schedules.first;
          _nextLesson = schedules.first.scheduleDetailInfo?.scheduleInfo;
          _timeStamp = DateTime.fromMillisecondsSinceEpoch(
            _nextLesson?.startTimeStamp ?? 0,
          );

          _startTimer();
        });
      },
      onError: (message) => SnackBarHelper.showErrorSnackBar(
        context: context,
        content: message,
      ),
    );
  }

  void _getTotalCall() async {
    await CallService.getTotalCall(
      onSuccess: (total) {
        setState(() {
          _totalCall = total;
        });
      },
      onError: (message) => SnackBarHelper.showErrorSnackBar(
        context: context,
        content: message,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Widget upcomingLessonWidget() {
    if (_nextLesson == null) {
      return Text(
        widget.local.noUpcomingLesson,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      );
    }

    final date =
        TimeHelper.convertTimeStampToDate(_nextLesson?.startTimeStamp ?? 0);

    final time =
        '${TimeHelper.convertTimeStampToHour(_nextLesson?.startTimeStamp ?? 0)}'
        ' - '
        '${TimeHelper.convertTimeStampToHour(_nextLesson?.endTimeStamp ?? 0)}';

    return Column(
      children: <Widget>[
        Text(
          widget.local.upcomingLesson,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          '$date $time',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          '${_checkLessonStart() ? '(${widget.local.startsIn} ' : '(${widget.local.inProgress} '}'
          '${TimeHelper.getRemainingTimer(_currentTime ?? Duration.zero)})',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: _checkLessonStart() ? Colors.yellow : Colors.green.shade300,
          ),
        ),
        const SizedBox(height: 18),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VideoCallScreen(
                  bookingInfo: _bookingInfo,
                ),
              ),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.ondemand_video_rounded,
                color: Colors.blue[500],
              ),
              const SizedBox(width: 14),
              Text(
                widget.local.enterLessonRoom,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue[500],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hour = (_totalCall ?? 0) ~/ 60;
    final minute = (_totalCall ?? 0) % 60;

    return Container(
      color: Colors.blue[800],
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 18),
          upcomingLessonWidget(),
          const SizedBox(height: 18),
          Text(
            _totalCall == 0
                ? widget.local.welcome
                : widget.local.totalLessonTime(hour, minute),
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
