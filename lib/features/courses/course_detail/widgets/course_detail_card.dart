import 'package:flutter/material.dart';
import 'package:lettutor/features/courses/course_topic/course_topic_screen.dart';
import 'package:lettutor/models/courses/course.dart';

class CourseDetailCard extends StatelessWidget {
  const CourseDetailCard({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          width: 0.5,
          color: Color.fromARGB(255, 195, 193, 193),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      borderOnForeground: true,
      shadowColor: const Color.fromARGB(255, 132, 132, 132),
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage(course.imageUrl ?? ''),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.error_outline_rounded,
              size: 32,
              color: Colors.redAccent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 22,
              horizontal: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  course.name ?? 'null name',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  course.description ?? 'null description',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CourseTopicScreen(courseTopic: course.topics![0]),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white),
                  child: const Text(
                    'Discover',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
