import 'package:flutter/material.dart';
import 'package:lettutor/widgets/app_bar.dart';
import 'package:lettutor/widgets/horizonal_stepper.dart';

class TutorBecomeScreen extends StatefulWidget {
  const TutorBecomeScreen({super.key});

  @override
  State<TutorBecomeScreen> createState() => _TutorBecomeScreenState();
}

class _TutorBecomeScreenState extends State<TutorBecomeScreen> {
  final Map<String, Widget> steps = <String, Widget>{
    'Complete profile': const Text('Complete profile'),
    'Video introdution': const Text('Video introdution'),
    'Approval': const Text('Approval'),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarLeading: true,
        appBarTitle: 'Become a Tutor',
      ),
      body: SizedBox(
        width: double.infinity,
        child: HorizontalStepper(steps: steps)
      ),
    );
  }
}
