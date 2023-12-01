import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/constants/custom/input_decoration.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/account/user/become_tutor/widgets/cerificate_dialog.dart';
import 'package:lettutor/widgets/drop_down.dart';
import 'package:lettutor/widgets/headline_text.dart';
import 'package:lettutor/widgets/helper_text.dart';
import 'package:lettutor/widgets/text_input.dart';

class ProfileResumeStep extends StatefulWidget {
  const ProfileResumeStep({super.key, this.formKey});

  final GlobalKey<FormState>? formKey;

  @override
  State<ProfileResumeStep> createState() => _ProfileResumeStepState();
}

class _ProfileResumeStepState extends State<ProfileResumeStep> {
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
  String? _teachingLevel;
  final List<String> _teachingSpecialities = <String>[];

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
            key: widget.formKey,
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
                  controller: _interestsTextEditingController,
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
                FormField(
                  builder: (FormFieldState state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      OutlinedButton(
                        onPressed: () {
                          _addCertificate(context);
                          state.didChange(_certificateList);
                        },
                        child: const Text('Add new certificate'),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: ['Certificate Type', 'Certificate', 'Action']
                              .map(
                                (label) => DataColumn(
                                  label: Text(
                                    label,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          rows: _certificateList
                              .map<DataRow>(
                                (certificate) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text(
                                          certificate['certificateType'] ?? ''),
                                    ),
                                    DataCell(
                                      Text(
                                        certificate['certificateFile']?.name ??
                                            '',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    DataCell(
                                      IconButton(
                                        onPressed: () {
                                          _removeCertificate(certificate);
                                          state.didChange(certificate);
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
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            state.errorText!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                    ],
                  ),
                  validator: (value) {
                    if (_certificateList.isEmpty) {
                      return 'Please input at least one certificate!';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const HeadlineText(textHeadline: 'Languages I speak'),
                const SizedBox(height: 12),
                const Text('Languages'),
                const SizedBox(height: 8),
                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: customInputDecoration.copyWith(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: -4,
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: List<DropdownMenuItem<String>>.generate(
                    worldLanguages.length,
                    (index) => DropdownMenuItem<String>(
                      enabled: false,
                      value: worldLanguages.keys.elementAt(index),
                      child: StatefulBuilder(
                        builder: (context, menuSetState) {
                          final isSelected = _languages
                              .contains(worldLanguages.keys.elementAt(index));
                          return InkWell(
                            onTap: () {
                              isSelected
                                  ? _languages.remove(
                                      worldLanguages.keys.elementAt(index))
                                  : _languages.add(
                                      worldLanguages.keys.elementAt(index));
                              setState(() {});
                              menuSetState(() {});
                            },
                            child: isSelected
                                ? ListTile(
                                    title: Text(
                                      worldLanguages.values.elementAt(index),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    tileColor:
                                        Colors.blue.shade100.withOpacity(0.4),
                                    trailing: Icon(
                                      Icons.check_rounded,
                                      color: Colors.blue.shade300,
                                    ),
                                  )
                                : ListTile(
                                    title: Text(
                                      worldLanguages.values.elementAt(index),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (_languages.isEmpty) {
                      return 'Please select at least one subject.';
                    }
                    return null;
                  },
                  hint: const Text('Select languages'),
                  onChanged: (value) {},
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.grey.shade300,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 8,
                  children: List<Widget>.generate(
                    _languages.length,
                    (index) => Chip(
                      label: Text(worldLanguages[_languages[index]]!),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      side: BorderSide.none,
                      onDeleted: () {
                        setState(() {
                          _languages.remove(_languages[index]);
                        });
                      },
                      deleteIcon: const Icon(
                        Icons.cancel_rounded,
                        size: 18,
                      ),
                      backgroundColor: Colors.grey.shade300.withOpacity(0.4),
                    ),
                  ),
                ),
                const HeadlineText(textHeadline: 'Who I teach'),
                const SizedBox(height: 12),
                const HelperText(
                  text: 'This is the first thing students '
                      'will see when looking for tutors.',
                ),
                const SizedBox(height: 12),
                const Text('Introduction'),
                TextInput(
                  controller: _introductionTextEditingController,
                  isTextArea: true,
                  hintText:
                      'Example: "I was a doctor for 35 years and can help you practice '
                      'business or medical English. I also enjoy teaching beginners '
                      'as I am very patient and always speak slowly and clearly."',
                  validator: 'Please input your introduction!',
                ),
                const Text('I am best at teaching students who are'),
                FormField(
                  builder: (FormFieldState state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: studentOverallLevels
                              .map<Widget>(
                                (level) => RadioListTile<String>(
                                  value: level,
                                  groupValue: _teachingLevel,
                                  onChanged: (value) {
                                    _teachingLevel = value!;
                                    state.didChange(value);
                                  },
                                  title: Text(
                                    level,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  contentPadding: const EdgeInsets.all(0),
                                ),
                              )
                              .toList(),
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              state.errorText!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (_teachingLevel == null) {
                      return 'Please input your teaching level!';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 12),
                const Text('My specialties are'),
                FormField(
                  builder: (FormFieldState state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: tutorSpecialities
                              .map<Widget>(
                                (specialty) => CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value:
                                      _teachingSpecialities.contains(specialty),
                                  onChanged: (value) {
                                    if (_teachingSpecialities
                                        .contains(specialty)) {
                                      _teachingSpecialities.remove(specialty);
                                    } else {
                                      _teachingSpecialities.add(specialty);
                                    }
                                    state.didChange(value);
                                  },
                                  title: Text(
                                    specialty,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  contentPadding: const EdgeInsets.all(0),
                                ),
                              )
                              .toList(),
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              state.errorText!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (_teachingSpecialities.isEmpty) {
                      return 'Please input your target specialties!';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
