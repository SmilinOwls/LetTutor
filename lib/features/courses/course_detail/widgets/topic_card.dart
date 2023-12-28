import 'package:flutter/material.dart';
import 'package:lettutor/features/courses/course_topic/course_topic_screen.dart';
import 'package:lettutor/constants/dto/courses/course.dart';

class CourseTopicCard extends StatelessWidget {
  const CourseTopicCard(
      {super.key, required this.index, required this.course});

  final int index;
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CourseTopicScreen(
                index: index,
                course: course,
              ),
            ));
          },
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 0.5,
                color: Color.fromARGB(255, 195, 193, 193),
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 2,
            borderOnForeground: true,
            child: Container(
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                '${index + 1}.\n${course.topics![index].name}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ));
  }
}
