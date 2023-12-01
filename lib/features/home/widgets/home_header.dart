import 'package:flutter/material.dart';
import 'package:lettutor/constants/routes.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[800],
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 18),
          const Text(
            'Upcomming Lesson',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            '2024-01-01 18:30-18:55',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
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
          const SizedBox(height: 18),
          const Text(
            'Total Lesson Time: 3 hours 30 minutes',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
