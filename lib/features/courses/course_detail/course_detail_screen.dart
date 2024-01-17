import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/features/courses/course_detail/widgets/course_detail_card.dart';
import 'package:lettutor/models/courses/course/course.dart';
import 'package:lettutor/services/courses_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/text/headline_text.dart';
import 'package:lettutor/features/courses/course_detail/widgets/topic_card.dart';
import 'package:lettutor/widgets/bar/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  Future<Course>? _courseDetail;
  late AppLocalizations _local;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getCourseDetail();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context)!;
  }

  void _getCourseDetail() async {
    final String courseId =
        ModalRoute.of(context)?.settings.arguments as String;
    CoursesService.getCourseDetailById(
      courseId: courseId,
      onSuccess: (course) {
        setState(() {
          _courseDetail = Future.value(course);
        });
      },
      onError: (message) => SnackBarHelper.showErrorSnackBar(
        context: context,
        content: message,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: _local.courseDetails,
      ),
      body: FutureBuilder(
        future: _courseDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Course course = snapshot.data as Course;
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Column(
                  children: <Widget>[
                    CourseDetailCard(course: course),
                    const SizedBox(height: 20),
                    HeadlineText(textHeadline: _local.overview),
                    const SizedBox(height: 14),
                    Row(
                      children: <Widget>[
                        Icon(Icons.help_outline, color: Colors.red[300]),
                        const SizedBox(width: 8),
                        Text(
                          _local.overviewOne,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 30),
                      child: Text(course.reason ?? ''),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: <Widget>[
                        Icon(Icons.help_outline, color: Colors.red[300]),
                        const SizedBox(width: 8),
                        Text(
                          _local.overviewTwo,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 30),
                      child: Text(course.purpose ?? ''),
                    ),
                    HeadlineText(textHeadline: _local.experienceLevel),
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
                            coursesLevel[course.level] ?? '',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    HeadlineText(textHeadline: _local.courseLength),
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
                            _local.numberOfTopics(course.topics!.length),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    HeadlineText(textHeadline: _local.listTopics),
                    ...List<Widget>.generate(
                      course.topics?.length ?? 0,
                      (index) => CourseTopicCard(
                        index: index,
                        course: course,
                      ),
                    ),
                    HeadlineText(textHeadline: _local.suggestedTutors),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 8,
                      ),
                      child: Column(
                        children: course.users?.map((user) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Text(
                                    user.name ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.tutorDetail,
                                        arguments: user.id,
                                      );
                                    },
                                    child: Text(
                                      _local.moreInfo,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList() ??
                            [],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
