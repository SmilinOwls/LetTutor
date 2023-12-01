import 'package:flutter/material.dart';
import 'package:lettutor/models/courses/course.dart';
import 'package:lettutor/widgets/app_bar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CourseTopicScreen extends StatefulWidget {
  const CourseTopicScreen(
      {super.key, required this.index, required this.course});

  final int index;
  final Course course;

  @override
  State<CourseTopicScreen> createState() => _CourseTopicScreenState();
}

class _CourseTopicScreenState extends State<CourseTopicScreen> {
  int _selectTopicIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                  Image(
                    image: AssetImage(widget.course.imageUrl ?? ''),
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
                          widget.course.name ?? 'null name',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          widget.course.description ?? 'null description',
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
                          widget.course.topics!.length,
                          (index) => ListTile(
                            onTap: () {
                              setState(() {
                                _selectTopicIndex = index;
                              });
                            },
                            selected: _selectTopicIndex == index,
                            selectedTileColor: Colors.grey[400],
                            selectedColor: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            leading: Text('${index + 1}.'),
                            leadingAndTrailingTextStyle:
                                Theme.of(context).textTheme.bodyLarge,
                            titleTextStyle:
                                Theme.of(context).textTheme.bodyLarge,
                            title: Text('${widget.course.topics![index].name}'),
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
