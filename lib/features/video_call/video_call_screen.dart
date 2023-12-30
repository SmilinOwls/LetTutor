import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/utils/time_helper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/bar/app_bar.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key, this.bookingInfo});

  final BookingInfo? bookingInfo;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  DateTime _timeStamp = DateTime.now();
  // bool _isHover = false;
  late Timer _timer;
  late Duration _currentTime;

  String? _studentMeetingLink;
  final _jitsiMeetPlugin = JitsiMeet();

  @override
  void initState() {
    super.initState();
    _getStudentMeetingLink();
    _startTimer();
  }

  void _getStudentMeetingLink() async {
    _studentMeetingLink = widget.bookingInfo?.studentMeetingLink;
    _timeStamp = DateTime.fromMillisecondsSinceEpoch(
        widget.bookingInfo?.scheduleDetailInfo?.scheduleInfo?.startTimeStamp ??
            0);
  }

  bool _checkLessonStart() {
    if (_timeStamp.isBefore(DateTime.now())) {
      return false;
    } else {
      return true;
    }
  }

  void _startTimer() {
    final now = DateTime.now();

    _currentTime = _checkLessonStart()
        ? now.difference(_timeStamp)
        : _timeStamp.difference(now);

    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_currentTime.inSeconds == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _currentTime = _timeStamp.difference(DateTime.now());
          });
        }
      },
    );
  }

  void _joinMeeting() async {
    final String meetingToken = _studentMeetingLink?.split('token=')[1] ?? '';

    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(meetingToken);
    final String room = jwtDecoded['room'];

    var options = JitsiMeetConferenceOptions(
      serverURL: "https://meet.lettutor.com",
      room: room,
      token: meetingToken,
      configOverrides: {
        "startWithAudioMuted": true,
        "startWithVideoMuted": true,
      },
      featureFlags: {
        "call-integration.enabled": false,
        "pip.enabled": false,
        "unsaferoomwarning.enabled": false,
        "ios.screensharing.enabled": true
      },
    );

    try {
      await _jitsiMeetPlugin.join(options);
    } catch (error) {
      if (mounted) {
        SnackBarHelper.showErrorSnackBar(
          context: context,
          content: error.toString(),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(appBarTitle: 'Video Call'),
        body: MouseRegion(
          // onEnter: (PointerEvent e) => setState(() => _isHover = true),
          // onExit: (PointerEvent e) => setState(() {
          //   _isHover = false;
          // }),
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black,
                  ),
                  child: Text(
                    '${TimeHelper.getRemainingTimer(_currentTime)} '
                    '${_checkLessonStart() ? 'until lesson starts' : 'lesson has started'} '
                    '(${DateFormat('E, dd MMM yy H:m').format(_timeStamp)})',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: _checkLessonStart()
                          ? Colors.yellow
                          : Colors.blue.shade300,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.5 - 80,
                bottom: MediaQuery.of(context).size.height * 0.3,
                child: InkWell(
                  onTap: _joinMeeting,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Colors.green,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.video_call,
                          color: Colors.white,
                          size: 48,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Join Meeting',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Positioned.fill(
              //   bottom: _isHover ? 20 : -50,
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Container(
              //       width: MediaQuery.of(context).size.width * 0.8,
              //       padding: const EdgeInsets.symmetric(vertical: 12),
              //       decoration: BoxDecoration(
              //         shape: BoxShape.rectangle,
              //         borderRadius: BorderRadius.circular(16),
              //         color: Colors.black,
              //       ),
              //       child: const Row(
              //         children: <Widget>[
              //           Expanded(
              //               child: Icon(
              //             Icons.mic_none_outlined,
              //             color: Colors.white,
              //           )),
              //           Expanded(
              //               child: Icon(
              //             Icons.video_camera_back_outlined,
              //             color: Colors.white,
              //           )),
              //           Expanded(
              //               child: Icon(
              //             Icons.screen_share_outlined,
              //             color: Colors.white,
              //           )),
              //           Expanded(
              //               child: Icon(
              //             Icons.comment_bank_outlined,
              //             color: Colors.white,
              //           )),
              //           Expanded(
              //               child: Icon(
              //             Icons.front_hand_outlined,
              //             color: Colors.white,
              //           )),
              //           Expanded(
              //               child: Icon(
              //             Icons.fullscreen_outlined,
              //             color: Colors.white,
              //           )),
              //           Expanded(
              //               child: Icon(
              //             Icons.more_horiz_outlined,
              //             color: Colors.white,
              //           )),
              //           Expanded(
              //               child: Icon(
              //             Icons.phone,
              //             color: Colors.red,
              //           )),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Positioned(
                bottom: 65,
                right: 25,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                      width: 62,
                      height: 62,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.bookingInfo?.scheduleDetailInfo
                                ?.scheduleInfo?.tutorInfo?.avatar ??
                            '',
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(
                            Icons.error,
                            size: 62,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
