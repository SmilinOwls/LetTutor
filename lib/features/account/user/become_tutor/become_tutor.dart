import 'package:flutter/material.dart';
import 'package:lettutor/features/account/user/become_tutor/widgets/stepper/approval_step.dart';
import 'package:lettutor/features/account/user/become_tutor/widgets/stepper/profile_resume_step.dart';
import 'package:lettutor/widgets/app_bar.dart';
import 'package:lettutor/widgets/horizonal_stepper.dart';

class BecomeTutorScreen extends StatefulWidget {
  const BecomeTutorScreen({super.key});

  @override
  State<BecomeTutorScreen> createState() => _BecomeTutorScreenState();
}

class _BecomeTutorScreenState extends State<BecomeTutorScreen> {
  final Map<String, Widget> steps = <String, Widget>{
    'Complete profile': const ProfileResumeStep(),
    'Video introdution': const Text('Video introdution'),
    'Approval': const ApprovalStep(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: 'Become a Tutor',
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.blue,
                secondary: Colors.blue,
              ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: HorizontalStepper(steps: steps),
        ),
      ),
    );
  }
}
