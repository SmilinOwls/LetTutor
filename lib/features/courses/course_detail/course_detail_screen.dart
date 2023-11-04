import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/features/courses/course_detail/widgets/course_detail_card.dart';
import 'package:lettutor/features/courses/course_detail/widgets/custom_headline.dart';
import 'package:lettutor/features/courses/course_detail/widgets/topic_card.dart';
import 'package:lettutor/widgets/app_bar.dart';
import '../../../models/courses/course.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  final Course courseDetail = courses[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarLeading: true,
        appBarTitle: 'Course Details',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            children: <Widget>[
              CourseDetailCard(course: courseDetail),
              const SizedBox(height: 20),
              const CustomHeadline(textHeadline: 'Overview'),
              const SizedBox(height: 14),
              Row(
                children: <Widget>[
                  Icon(Icons.help_outline, color: Colors.red[300]),
                  const SizedBox(width: 8),
                  Text(
                    'Why take this course',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 30),
                child: Text(courseDetail.reason ?? 'No reason available'),
              ),
              const SizedBox(height: 14),
              Row(
                children: <Widget>[
                  Icon(Icons.help_outline, color: Colors.red[300]),
                  const SizedBox(width: 8),
                  Text(
                    'What will you be able to do',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 30),
                child: Text(courseDetail.purpose ?? 'No purpose available'),
              ),
              const CustomHeadline(textHeadline: 'Experience Level'),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 8,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.group_add_outlined,
                      color: Colors.blue[700],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      courseDetail.level ?? 'No level available',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const CustomHeadline(textHeadline: 'Course Length'),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 8,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.book_outlined,
                      color: Colors.blue[700],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${courseDetail.topics!.length} topics',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const CustomHeadline(textHeadline: 'List Topics'),
              ...List<Widget>.generate(
                courseDetail.topics?.length ?? 0,
                (index) => CourseTopicCard(
                  index: index,
                  course: courseDetail,
                ),
              ),
              const CustomHeadline(textHeadline: 'Suggested Tutors'),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 8,
                ),
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: <Widget>[
                    Text(
                      'Keegan',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.tutorDetail);
                      },
                      child: const Text(
                        'More info',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
