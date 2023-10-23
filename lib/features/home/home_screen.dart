import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/features/home/widgets/home_header.dart';
import 'package:lettutor/features/home/widgets/tutor_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HomeHeader(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Text('Recommend Tutors',
                style: Theme.of(context).textTheme.displaySmall),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: teachers.length,
            itemBuilder: (content, index) => TutorCard(tutor: teachers[index]),
          )
        ],
      ),
    );
  }
}
