import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/courses/course_list/widgets/ebook_card.dart';

class Ebook extends StatefulWidget {
  const Ebook({super.key});

  @override
  State<Ebook> createState() => _EbookState();
}

class _EbookState extends State<Ebook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListView.builder(
          itemCount: ebooks.length,
          itemBuilder: (context, index) => EbookCard(ebook: ebooks[index])),
    );
  }
}
