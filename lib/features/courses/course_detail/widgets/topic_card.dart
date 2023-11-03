import 'package:flutter/material.dart';
import 'package:lettutor/models/courses/course_topic.dart';

class CourseTopicCard extends StatelessWidget {
  const CourseTopicCard(
      {super.key, required this.index, required this.courseTopic});

  final int index;
  final List<CourseTopic> courseTopic;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: InkWell(
          onTap: () {},
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 0.5,
                color: Color.fromARGB(255, 195, 193, 193),
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 2,
            borderOnForeground: true,
            child: Container(
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                '${index + 1}.\n${courseTopic[index].name}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ));
  }
}
