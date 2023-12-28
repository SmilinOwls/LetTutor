import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/models/schedule/schedule_info.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/services/call_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/utils/time_helper.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int? _totalCall;
  ScheduleInfo? _nextLesson;
  Timer? _timer;
  Duration? _currentTime;

  @override
  void initState() {
    super.initState();
    _getMostUpcommingLesson();
    _getTotalCall();
  }

  void _startTimer(DateTime timeStamp) {
    _currentTime = timeStamp.difference(DateTime.now());
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
            _currentTime = timeStamp.difference(DateTime.now());
          });
        }
      },
    );
  }

  void _getMostUpcommingLesson() async {
    await BookingService.getTutorNextBookingList(
      onSuccess: (schedules) {
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
          _nextLesson = schedules.first.scheduleDetailInfo?.scheduleInfo;
          _startTimer(
            DateTime.fromMillisecondsSinceEpoch(
              _nextLesson?.startTimeStamp ?? 0,
            ),
          );
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
     if(_nextLesson == null) return const SizedBox.shrink();

     final date = DateFormat.yMMMEd().format(
      DateTime.fromMillisecondsSinceEpoch(
        _nextLesson?.startTimeStamp ?? 0,
      ),
    );
    final time = '${TimeHelper.convertTimeStampToHour(_nextLesson?.startTimeStamp ?? 0)}'
        ' - '
        '${TimeHelper.convertTimeStampToHour(_nextLesson?.endTimeStamp ?? 0)}';

    return Column(
      children: [
        const SizedBox(height: 18),
        const Text(
          'Upcomming Lesson',
          style: TextStyle(
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
          '(starts in ${TimeHelper.getRemainingTimer(_currentTime ?? Duration.zero)})',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.yellow,
          ),
        ),
        const SizedBox(height: 18),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.videoCall);
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
                'Enter Lesson Room',
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
          upcomingLessonWidget(),
          const SizedBox(height: 18),
          Text(
            'Total Lesson Time: $hour hours $minute minutes',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
