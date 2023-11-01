import 'package:flutter/material.dart';

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
          const Text(
            '2023-10-23  18:30-18:55',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 18),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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
