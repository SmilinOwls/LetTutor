import 'package:flutter/material.dart';
import 'package:lettutor/widgets/app_bar.dart';

class TutorBookScreen extends StatefulWidget {
  const TutorBookScreen({super.key});

  @override
  State<TutorBookScreen> createState() => _TutorBookScreenState();
}

class _TutorBookScreenState extends State<TutorBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          appBarLeading: true,
          appBarTitle: 'Book tutor',
        ),
        body: Container()
        
      );
  }
}
