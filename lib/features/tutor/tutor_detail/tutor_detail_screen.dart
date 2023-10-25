import 'package:flutter/material.dart';
import 'package:lettutor/widgets/app_bar.dart';

class TutorDetailScreen extends StatefulWidget {
  const TutorDetailScreen({super.key});

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        appBarLeading: true,
        appBarTitle: 'Tutor Details',
      ),
      body: SingleChildScrollView(
        child: Column(children: []),
      ),
    );
  }
}
