import 'package:flutter/material.dart';
import 'package:lettutor/features/courses/course_list/widgets/course/course_card.dart';
import 'package:lettutor/models/courses/course/course.dart';
import 'package:lettutor/services/courses_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:pager/pager.dart';

class CourseTab extends StatefulWidget {
  const CourseTab({super.key, required this.searchs});

  final Map<String, dynamic> searchs;

  @override
  State<CourseTab> createState() => _CourseTabState();
}

class _CourseTabState extends State<CourseTab> {
  Future<List<Course>>? _courses;
  Map<String, dynamic>? searchList;

  int _page = 1;
  final int _perPage = 10;
  late int _totalPages;

  @override
  void initState() {
    super.initState();
    searchList = widget.searchs;
    _getCourseList();
  }

  void _getCourseList() {
    CoursesService.searchCourse(
      page: _page,
      size: _perPage,
      search: searchList?['search'],
      categoryId: searchList?['categoryId'],
      level: searchList?['level'],
      orderBy: searchList?['orderBy'],
      onSuccess: (total, courses) {
        _totalPages = (total / _perPage).ceil();
        _sortCourses(courses);
      },
      onError: (message) {
        SnackBarHelper.showErrorSnackBar(
          context: context,
          content: message,
        );
      },
    );
  }

  void _sortCourses(List<Course> courses) {
    Map<String, List<Course>> courseMap = {};
    for (var course in courses) {
      final String key = course.categories?.first.key ?? 'null key';
      if (courseMap.containsKey(key)) {
        courseMap[key]!.add(course);
      } else {
        courseMap[key] = [course];
      }
    }
    final List<Course> sortedCourses = [];
    courseMap.forEach((key, value) {
      sortedCourses.addAll(value);
    });

    setState(() {
      _courses = Future.value(sortedCourses);
    });
  }

  void _onPageChanged(int page) {
    setState(() {
      _page = page;
      _courses = null;
    });
    _getCourseList();
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
            child: Column(
              children: <Widget>[
                Pager(
                  currentItemsPerPage: _perPage,
                  currentPage: _page,
                  totalPages: _totalPages,
                  onPageChanged: _onPageChanged,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    primary: false,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: courses.length,
                    itemBuilder: (context, index) =>
                        CourseCard(course: courses[index]),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
