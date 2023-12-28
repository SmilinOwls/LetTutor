import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/courses/course_list/widgets/ebook/ebook_card.dart';

class EbookTab extends StatefulWidget {
  const EbookTab({super.key});

  @override
  State<EbookTab> createState() => _EbookTabState();
}

class _EbookTabState extends State<EbookTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListView.builder(
        primary: false,
        itemCount: ebooks.length,
        itemBuilder: (context, index) => EbookCard(ebook: ebooks[index]),
      ),
    );
  }
}
