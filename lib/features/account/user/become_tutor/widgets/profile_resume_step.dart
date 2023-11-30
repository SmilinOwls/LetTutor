import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/account/user/become_tutor/widgets/cerificate_dialog.dart';
import 'package:lettutor/widgets/drop_down.dart';
import 'package:lettutor/widgets/headline_text.dart';
import 'package:lettutor/widgets/helper_text.dart';
import 'package:lettutor/widgets/text_input.dart';

class ProfileResumeStep extends StatefulWidget {
  const ProfileResumeStep({super.key});

  @override
  State<ProfileResumeStep> createState() => _ProfileResumeStepState();
}

class _ProfileResumeStepState extends State<ProfileResumeStep> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _birthdayTextEditingController =
      TextEditingController();
  final TextEditingController _countryTextEditingController =
      TextEditingController();
  final TextEditingController _interestTextEditingController =
      TextEditingController();
  final TextEditingController _educationTextEditingController =
      TextEditingController();
  final TextEditingController _experienceTextEditingController =
      TextEditingController();
  final TextEditingController _professionTextEditingController =
      TextEditingController();
  final List<Map<String, dynamic>> _certificateList = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();
    _nameTextEditingController.text = 'Keegan';
  }

  void _onDateChanged(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse('1999-01-01'),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      setState(() {
        _birthdayTextEditingController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _addCertificate(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => CerificateDialog(certificates: _certificateList),
    ).then((value) {
      if (value != null) {
        setState(() {
          _certificateList.add(value);
        });
      }
    });
  }

  void _removeCertificate(Map<String, dynamic> certificate) {
    setState(() {
      _certificateList.remove(certificate);
    });
  }

  void _onProfileChangeSubmited() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  void dispose() {
    super.dispose();
    _nameTextEditingController.dispose();
    _birthdayTextEditingController.dispose();
    _countryTextEditingController.dispose();
    _interestTextEditingController.dispose();
    _educationTextEditingController.dispose();
    _experienceTextEditingController.dispose();
    _professionTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/misc/profile_setup.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person_rounded, size: 62),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Set up your tutor profile',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your tutor profile is your chance to market yourself to students on Tutoring. '
                      'You can make edits later on your profile settings page.',
                    ),
                    const SizedBox(height: 8),
                    const Text(
                        'New students may browse tutor profiles to find a tutor that fits their learning goals and personality. '
                        'Returning students may use the tutor profiles to find tutors they\'ve had great experiences with already.'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const HeadlineText(textHeadline: 'Basic Info'),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 140,
                    height: 140,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/avatar/user/user_avatar.jpeg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person_rounded, size: 62),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const HelperText(
                  text: 'Please upload a professional photo. See guildlines.',
                ),
                const SizedBox(height: 12),
                const Text('Tutoring name'),
                TextInput(
                  controller: _nameTextEditingController,
                  validator: 'Please input your name!',
                ),
                const Text('I\'m from'),
                DropDownField(
                  controller: _countryTextEditingController,
                  list: countryList,
                  validator: 'Please input your country!',
                ),
                const Text('Date of Birth'),
                TextInput(
                  controller: _birthdayTextEditingController,
                  isReadOnly: true,
                  inputDecoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_month_outlined,
                      size: 20,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  onTap: () {
                    _onDateChanged(context);
                  },
                  validator: 'Please input your birthday!',
                ),
                const HeadlineText(textHeadline: 'CV'),
                const SizedBox(height: 12),
                const Text(
                  'Students will view this information on your profile to decide '
                  'if you\'re a good fit for them.',
                ),
                const SizedBox(height: 12),
                const HelperText(
                  text: 'In order to protect your privacy, '
                      'please do not share your personal information '
                      '(email, phone number, social email, skype, etc) in your profile.',
                ),
                const SizedBox(height: 12),
                const Text('Interests'),
                TextInput(
                  controller: _interestTextEditingController,
                  isTextArea: true,
                  hintText:
                      'Interests, hobbies, memorable life experiences, or anything '
                      'else you\'d like to share!',
                  validator: 'Please input your interests!',
                ),
                const Text('Education'),
                TextInput(
                  controller: _educationTextEditingController,
                  isTextArea: true,
                  hintText:
                      'Example: "Bachelor of Arts in English from Cambly University; '
                      'Certified yoga instructor, Second Language Acquisition and Teaching '
                      '(SLAT) certificate from Cambly University"',
                  validator: 'Please input your interests!',
                ),
                const Text('Experience'),
                TextInput(
                  controller: _experienceTextEditingController,
                  isTextArea: true,
                  validator: 'Please input your experience!',
                ),
                const Text('Current or Previous Pression'),
                TextInput(
                  controller: _professionTextEditingController,
                  isTextArea: true,
                  validator: 'Please input your profession!',
                ),
                const Text('Certificate'),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    _addCertificate(context);
                  },
                  child: const Text('Add new certificate'),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Certificate Type',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Certificate',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Action',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                    rows: _certificateList
                        .map<DataRow>(
                          (certificate) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Text(certificate['certificateType'] ?? ''),
                              ),
                              DataCell(
                                Text(
                                  certificate['certificateFile']?.name ?? '',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  onPressed: () {
                                    _removeCertificate(certificate);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}