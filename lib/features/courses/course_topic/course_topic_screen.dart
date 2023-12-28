import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/models/courses/course/course.dart';
import 'package:lettutor/widgets/app_bar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CourseTopicScreen extends StatefulWidget {
  const CourseTopicScreen({
    super.key,
    required this.index,
    required this.course,
  });

  final int index;
  final Course course;

  @override
  State<CourseTopicScreen> createState() => _CourseTopicScreenState();
}

class _CourseTopicScreenState extends State<CourseTopicScreen> {
  int _selectTopicIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Course course = widget.course;

    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: 'Expore Course',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        child: Column(
          children: <Widget>[
            Card(
              color: Theme.of(context).cardColor,
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 2,
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
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          course.description ?? 'null description',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'List Topics',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ...List<Widget>.generate(
                          course.topics!.length,
                          (index) => ListTile(
                            onTap: () {
                              setState(() {
                                _selectTopicIndex = index;
                              });
                            },
                            selected: _selectTopicIndex == index,
                            selectedTileColor: Colors.grey[400],
                            selectedColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            leading: Text('${index + 1}.'),
                            leadingAndTrailingTextStyle:
                                Theme.of(context).textTheme.bodyLarge,
                            titleTextStyle:
                                Theme.of(context).textTheme.bodyLarge,
                            title: Text('${course.topics![index].name}'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: SfPdfViewer.network(
                  widget.course.topics![_selectTopicIndex].nameFile ?? ''),
            )
          ],
        ),
      ),
    );
  }
}
