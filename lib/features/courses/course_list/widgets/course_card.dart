import 'package:flutter/material.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/models/courses/course.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.courseDetail,
          arguments: course.id ?? 'null id',
        );
      },
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 0.5,
                color:  Color.fromARGB(255, 195, 193, 193),
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
                    vertical: 12,
                    horizontal: 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        course.name ?? 'null name',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        course.description ?? 'null description',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              course.level ?? 'null level',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            course.topics != null
                                ? '${course.topics!.length} lessons'
                                : 'null lesson',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
