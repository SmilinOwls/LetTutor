import 'package:flutter/material.dart';
import 'package:lettutor/features/courses/course_list/widgets/ebook/ebook_card.dart';
import 'package:lettutor/models/courses/ebook/ebook.dart';
import 'package:lettutor/services/courses_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:pager/pager.dart';

class EbookTab extends StatefulWidget {
  const EbookTab({super.key, required this.searchs});

  final Map<String, dynamic> searchs;

  @override
  State<EbookTab> createState() => _EbookTabState();
}

class _EbookTabState extends State<EbookTab> {
  Future<List<EBook>>? _ebooks;
  Map<String, dynamic>? searchList;

  int _page = 1;
  final int _perPage = 10;
  late int _totalPages;

  @override
  void initState() {
    super.initState();
    searchList = widget.searchs;
    _getEbookList();
  }

  void _getEbookList() {
    CoursesService.searchEbook(
      page: _page,
      size: _perPage,
      search: searchList?['search'],
      categoryId: searchList?['categoryId'],
      level: searchList?['level'],
      orderBy: searchList?['orderBy'],
      onSuccess: (total, ebooks) {
        _totalPages = (total / _perPage).ceil();
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
      ..sort((lowerLevelEbook, upperLevelEbook) =>
          lowerLevelEbook.level!.compareTo(upperLevelEbook.level!));

    setState(() {
      _ebooks = Future.value(sortedEbooks);
    });
  }

  void _onPageChanged(int page) {
    setState(() {
      _page = page;
      _ebooks = null;
    });
    _getEbookList();
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
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context)
                  .copyWith(scrollbars: false), // hide scrollbar
              child: ListView(
                children: <Widget>[
                  Pager(
                    currentItemsPerPage: _perPage,
                    currentPage: _page,
                    totalPages: _totalPages,
                    onPageChanged: _onPageChanged,
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    primary: false,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ebooks.length,
                    itemBuilder: (context, index) =>
                        EbookCard(ebook: ebooks[index]),
                  ),
                  const SizedBox(height: 20),
                  Pager(
                    currentItemsPerPage: _perPage,
                    currentPage: _page,
                    totalPages: _totalPages,
                    onPageChanged: _onPageChanged,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
