import 'package:flutter/material.dart';
import 'dart:async';

import 'package:intl/intl.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final DateTime _timeStamp = DateTime(2024, 1, 1, 18, 30);
  bool _isHover = false;
  late Timer _timer;
  late Duration _currentTime;

  void _startTimer() {
    _currentTime = _timeStamp.difference(DateTime.now());
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

  String get _getRemainingTimer {
    final String days = _currentTime.inDays.toString().padLeft(2, '0');
    final String hours =
        _currentTime.inHours.remainder(7).toString().padLeft(2, '0');
    final String minutes =
        _currentTime.inMinutes.remainder(24).toString().padLeft(2, '0');
    final String seconds =
        _currentTime.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$days:$hours:$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
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
        backgroundColor: const Color.fromARGB(255, 67, 66, 66),
        body: MouseRegion(
          onEnter: (PointerEvent e) => setState(() => _isHover = true),
          onExit: (PointerEvent e) => setState(() {
            _isHover = false;
          }),
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
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
                    '$_getRemainingTimer until lesson start (${DateFormat('E, dd MMM yy H:m').format(_timeStamp)})',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Positioned.fill(
                bottom: _isHover ? 20 : -50,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black,
                    ),
                    child: const Row(
                      children: <Widget>[
                        Expanded(
                            child: Icon(
                          Icons.mic_none_outlined,
                          color: Colors.white,
                        )),
                        Expanded(
                            child: Icon(
                          Icons.video_camera_back_outlined,
                          color: Colors.white,
                        )),
                        Expanded(
                            child: Icon(
                          Icons.screen_share_outlined,
                          color: Colors.white,
                        )),
                        Expanded(
                            child: Icon(
                          Icons.comment_bank_outlined,
                          color: Colors.white,
                        )),
                        Expanded(
                            child: Icon(
                          Icons.front_hand_outlined,
                          color: Colors.white,
                        )),
                        Expanded(
                            child: Icon(
                          Icons.fullscreen_outlined,
                          color: Colors.white,
                        )),
                        Expanded(
                            child: Icon(
                          Icons.more_horiz_outlined,
                          color: Colors.white,
                        )),
                        Expanded(
                            child: Icon(
                          Icons.phone,
                          color: Colors.red,
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 65,
                right: 25,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 62,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: const AssetImage(
                          'assets/avatar/tutor/keegan_tutor_avatar.jpeg'),
                      onBackgroundImageError: (exception, stackTrace) =>
                          const Icon(Icons.person_outline_rounded, size: 62),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
