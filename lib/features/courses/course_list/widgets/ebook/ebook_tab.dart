import 'package:flutter/material.dart';
import 'package:lettutor/features/courses/course_list/widgets/ebook/ebook_card.dart';
import 'package:lettutor/models/courses/ebook/ebook.dart';
import 'package:lettutor/services/courses_service.dart';
import 'package:lettutor/utils/snack_bar.dart';

class EbookTab extends StatefulWidget {
  const EbookTab({super.key});

  @override
  State<EbookTab> createState() => _EbookTabState();
}

class _EbookTabState extends State<EbookTab> {
  Future<List<EBook>>? _ebooks;

  @override
  void initState() {
    super.initState();
    _getCourseList();
  }

  void _getCourseList() {
    CoursesService.getListEbookWithPagination(
      page: 1,
      size: 100,
      onSuccess: (ebooks) {
        _sortEbooks(ebooks);
      },
      onError: (message) {
        SnackBarHelper.showErrorSnackBar(
          context: context,
          content: message,
        );
      },
    );
  }

  void _sortEbooks(List<EBook> courses) {
    final sortedEbooks = courses
      ..sort((lowerLevelEbook, upperLevelEbook) => lowerLevelEbook.level!.compareTo(upperLevelEbook.level!));

    setState(() {
      _ebooks = Future.value(sortedEbooks);
    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _ebooks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<EBook> ebooks = snapshot.data as List<EBook>;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListView.builder(
                primary: false,
                itemCount: ebooks.length,
                itemBuilder: (context, index) =>
                    EbookCard(ebook: ebooks[index]),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
