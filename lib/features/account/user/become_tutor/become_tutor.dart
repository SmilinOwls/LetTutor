import 'package:flutter/material.dart';
import 'package:lettutor/features/account/user/become_tutor/widgets/approval_step.dart';
import 'package:lettutor/features/account/user/become_tutor/widgets/profile_resume_step.dart';
import 'package:lettutor/features/account/user/become_tutor/widgets/video_introduction_step.dart';
import 'package:lettutor/models/user/user.dart';
import 'package:lettutor/widgets/bar/app_bar.dart';
import 'package:lettutor/widgets/stepper/horizonal_stepper.dart';

class BecomeTutorScreen extends StatefulWidget {
  const BecomeTutorScreen({super.key, this.user});

  final User? user;

  @override
  State<BecomeTutorScreen> createState() => _BecomeTutorScreenState();
}

class _BecomeTutorScreenState extends State<BecomeTutorScreen> {
  final GlobalKey<FormState> _formKeyStep1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyStep2 = GlobalKey<FormState>();

  late final Map<String, Widget> steps;

  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _birthdayTextEditingController =
      TextEditingController();
  final TextEditingController _countryTextEditingController =
      TextEditingController();
  final TextEditingController _interestsTextEditingController =
      TextEditingController();
  final TextEditingController _educationTextEditingController =
      TextEditingController();
  final TextEditingController _experienceTextEditingController =
      TextEditingController();
  final TextEditingController _professionTextEditingController =
      TextEditingController();
  final TextEditingController _introductionTextEditingController =
      TextEditingController();
  final List<Map<String, dynamic>> _certificateList = <Map<String, dynamic>>[];

  final List<String> _languages = <String>[];
  final List<String?> _teachingLevel = <String?>[null];
  final List<String> _teachingSpecialities = <String>[];

  @override
  void initState() {
    super.initState();
    steps = <String, Widget>{
      'Complete profile': ProfileResumeStep(
        formKey: _formKeyStep1,
        nameTextEditingController: _nameTextEditingController,
        birthdayTextEditingController: _birthdayTextEditingController,
        countryTextEditingController: _countryTextEditingController,
        interestsTextEditingController: _interestsTextEditingController,
        educationTextEditingController: _educationTextEditingController,
        experienceTextEditingController: _experienceTextEditingController,
        professionTextEditingController: _professionTextEditingController,
        introductionTextEditingController: _introductionTextEditingController,
        certificateList: _certificateList,
        languages: _languages,
        teachingLevel: _teachingLevel,
        teachingSpecialities: _teachingSpecialities,
      ),
      'Video introdution': VideoIntroductionStep(
        formKey: _formKeyStep2,
      ),
      'Approval': const ApprovalStep(),
    };
  }

  @override
  void dispose() {
    super.dispose();
    _nameTextEditingController.dispose();
    _birthdayTextEditingController.dispose();
    _countryTextEditingController.dispose();
    _interestsTextEditingController.dispose();
    _educationTextEditingController.dispose();
    _experienceTextEditingController.dispose();
    _professionTextEditingController.dispose();
    _introductionTextEditingController.dispose();
  }

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
          child: HorizontalStepper(
            steps: steps,
            formKey: [
              _formKeyStep1,
              _formKeyStep2,
            ],
          ),
        ),
      ),
    );
  }
}
