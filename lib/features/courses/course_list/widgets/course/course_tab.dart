import 'package:flutter/material.dart';
import 'package:lettutor/features/courses/course_list/widgets/course/course_card.dart';
import 'package:lettutor/models/courses/course.dart';
import 'package:lettutor/services/course_service.dart';
import 'package:lettutor/utils/snack_bar.dart';

class CourseTab extends StatefulWidget {
  const CourseTab({super.key});

  @override
  State<CourseTab> createState() => _CourseTabState();
}

class _CourseTabState extends State<CourseTab> {
  Future<List<Course>>? _courses;

  @override
  void initState() {
    super.initState();
    _getCourseList();
  }

  void _getCourseList() {
    CourseService.getListCourseWithPagination(
      page: 1,
      size: 10,
      onSuccess: (courses) {
        setState(() {
          _courses = Future.value(courses);
        });
      },
      onError: (message) {
        SnackBarHelper.showErrorSnackBar(
          context: context,
          content: message,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _courses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Course> courses = snapshot.data as List<Course>;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListView.builder(
                primary: false,
                itemCount: courses.length,
                itemBuilder: (context, index) =>
                    CourseCard(course: courses[index]),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
