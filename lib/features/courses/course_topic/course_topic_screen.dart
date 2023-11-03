import 'package:flutter/material.dart';
import 'package:lettutor/models/courses/course_topic.dart';
import 'package:lettutor/widgets/app_bar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CourseTopicScreen extends StatelessWidget {
  const CourseTopicScreen({super.key, required this.courseTopic});

  final CourseTopic courseTopic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarLeading: true,
        appBarTitle: 'Expore Course',
      ),
      body: SfPdfViewer.network(courseTopic.nameFile ?? ''),
    );
  }
}
