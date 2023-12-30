import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/features/courses/course_topic/course_topic_screen.dart';
import 'package:lettutor/models/courses/course/course.dart';

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
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      borderOnForeground: true,
      shadowColor: const Color.fromARGB(255, 132, 132, 132),
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: course.imageUrl ?? 'null image url',
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              size: 62,
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
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CourseTopicScreen(
                        index: 0,
                        course: course,
                      ),
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
