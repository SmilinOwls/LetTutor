import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/constants/custom/input_decoration.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/account/user/become_tutor/widgets/cerificate_dialog.dart';
import 'package:lettutor/models/injection/injection.dart';
import 'package:lettutor/models/tutor/tutor_become.dart';
import 'package:lettutor/models/user/user.dart';
import 'package:lettutor/services/user_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/drop_down/drop_down.dart';
import 'package:lettutor/widgets/text/headline_text.dart';
import 'package:lettutor/widgets/text/helper_text.dart';
import 'package:lettutor/widgets/form_field/text_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileResumeStep extends StatefulWidget {
  const ProfileResumeStep({
    super.key,
    required this.formKey,
    required this.nameTextEditingController,
    required this.birthdayTextEditingController,
    required this.countryTextEditingController,
    required this.interestsTextEditingController,
    required this.educationTextEditingController,
    required this.experienceTextEditingController,
    required this.professionTextEditingController,
    required this.introductionTextEditingController,
    required this.certificateList,
    required this.languages,
    required this.teachingLevel,
    required this.teachingSpecialities,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameTextEditingController;
  final TextEditingController birthdayTextEditingController;
  final TextEditingController countryTextEditingController;
  final TextEditingController interestsTextEditingController;
  final TextEditingController educationTextEditingController;
  final TextEditingController experienceTextEditingController;
  final TextEditingController professionTextEditingController;
  final TextEditingController introductionTextEditingController;
  final List<Map<String, dynamic>> certificateList;
  final List<String> languages;
  final List<String?> teachingLevel;
  final List<String> teachingSpecialities;

  @override
  State<ProfileResumeStep> createState() => _ProfileResumeStepState();
}

class _ProfileResumeStepState extends State<ProfileResumeStep> {
  User? user;
  late AppLocalizations _local;
  TutorBecome tutorBecome = getIt.get<TutorBecome>();

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
  }

  void _getUser() async {
    UserService.getUserInfo(
      onSuccess: (user) {
        setState(() {
          this.user = user;
          widget.nameTextEditingController.text = user.name ?? '';
          widget.countryTextEditingController.text = user.country ?? '';
          widget.birthdayTextEditingController.text = user.birthday ?? '';

          tutorBecome.name = user.name ?? '';
          tutorBecome.avatar = File(user.avatar ?? '');
          tutorBecome.country = user.country ?? '';
          tutorBecome.birthday = user.birthday ?? '';
        });
      },
      onError: (message) => SnackBarHelper.showErrorSnackBar(
        context: context,
        content: message,
      ),
    );
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
        widget.birthdayTextEditingController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _addCertificate(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) =>
          CerificateDialog(certificates: widget.certificateList),
    ).then((value) {
      if (value != null) {
        setState(() {
          widget.certificateList.add(value);
        });
      }
    });
  }

  void _removeCertificate(Map<String, dynamic> certificate) {
    setState(() {
      widget.certificateList.remove(certificate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
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
                            _local.setUpTutorProfile,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 24),
                          ),
                          const SizedBox(height: 8),
                          Text(_local.setUpTutorProfileDescription),
                          const SizedBox(height: 8),
                          Text(_local.setUpTutorProfileSubDescription),
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
                      HeadlineText(textHeadline: _local.basicInfo),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            width: 140,
                            height: 140,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: user?.avatar ?? '',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 140,
                              ),
                              errorWidget: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.error_outline_rounded,
                                color: Colors.red,
                                size: 140,
                              ),
                            )),
                      ),
                      const SizedBox(height: 12),
                      HelperText(text: _local.imageUploadHint),
                      const SizedBox(height: 12),
                      Text(_local.tutoringName),
                      TextInput(
                        controller: widget.nameTextEditingController,
                        validator: _local.tutoringNameInputValidator,
                        onChanged: (value) {
                          tutorBecome.name = value;
                        },
                      ),
                      Text(_local.imFrom),
                      DropDownField(
                        controller: widget.countryTextEditingController,
                        list: countryList,
                        validator: _local.countryInputValidator,
                        onSelected: (value) {
                          tutorBecome.country = value;
                        },
                        value: user?.country ?? '',
                      ),
                      Text(_local.dateOfBirth),
                      TextInput(
                        controller: widget.birthdayTextEditingController,
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
                          tutorBecome.birthday = widget
                              .birthdayTextEditingController.text
                              .toString();
                        },
                        validator: _local.dateOfBirthInputValidator,
                      ),
                      HeadlineText(textHeadline: _local.cv),
                      const SizedBox(height: 12),
                      Text(_local.cvDescription),
                      const SizedBox(height: 12),
                      HelperText(text: _local.cvInputHint),
                      const SizedBox(height: 12),
                      Text(_local.interests),
                      TextInput(
                        controller: widget.interestsTextEditingController,
                        isTextArea: true,
                        hintText: _local.interestsInputHint,
                        validator: _local.interestsInputValidator,
                        onChanged: (value) {
                          tutorBecome.interests = value;
                        },
                      ),
                      Text(_local.education),
                      TextInput(
                        controller: widget.educationTextEditingController,
                        isTextArea: true,
                        hintText: _local.educationInputHint,
                        validator: _local.educationInputValidator,
                        onChanged: (value) {
                          tutorBecome.education = value;
                        },
                      ),
                      Text(_local.experience),
                      TextInput(
                        controller: widget.experienceTextEditingController,
                        isTextArea: true,
                        validator: _local.experienceInputValidator,
                        onChanged: (value) {
                          tutorBecome.experience = value;
                        },
                      ),
                      Text(_local.profession),
                      TextInput(
                        controller: widget.professionTextEditingController,
                        isTextArea: true,
                        validator: _local.professionInputValidator,
                        onChanged: (value) {
                          tutorBecome.profession = value;
                        },
                      ),
                      Text(_local.certificate),
                      const SizedBox(height: 12),
                      FormField(
                        builder: (FormFieldState state) {
                          tutorBecome.certificateMapping = widget
                              .certificateList
                              .map<Map<String, String>>((certificate) => {
                                    "certificateType":
                                        certificate['certificateType'],
                                    "certificateFileName":
                                        certificate['certificateFile']?.name,
                                  })
                              .toList();
                          // tutorBecome.certificate = widget.certificateList
                          //     .map<File>((certificate) =>
                          //         File(certificate['certificateFile'].path))
                          //     .toList();
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                OutlinedButton(
                                  onPressed: () {
                                    _addCertificate(context);
                                    state.didChange(widget.certificateList);
                                  },
                                  child: Text(_local.addCertificate),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: [
                                      _local.certificateType,
                                      _local.certificate,
                                      _local.action,
                                    ]
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
                                    rows: widget.certificateList
                                        .map<DataRow>(
                                          (certificate) => DataRow(
                                            cells: <DataCell>[
                                              DataCell(
                                                Text(certificate[
                                                        'certificateType'] ??
                                                    ''),
                                              ),
                                              DataCell(
                                                Text(
                                                  certificate['certificateFile']
                                                          ?.name ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              DataCell(
                                                IconButton(
                                                  onPressed: () {
                                                    _removeCertificate(
                                                        certificate);
                                                    state
                                                        .didChange(certificate);
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
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
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                    ),
                                  ),
                              ]);
                        },
                        validator: (value) {
                          if (widget.certificateList.isEmpty) {
                            return _local.certificateInputValidator;
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      HeadlineText(textHeadline: _local.languagesISpeak),
                      const SizedBox(height: 12),
                      Text(_local.languages),
                      const SizedBox(height: 8),
                      FormField(
                        builder: (FormFieldState state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DropdownButtonFormField2<String>(
                                isExpanded: true,
                                decoration: customInputDecoration.copyWith(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: -4,
                                  ),
                                ),
                                items: List<DropdownMenuItem<String>>.generate(
                                  worldLanguages.length,
                                  (index) => DropdownMenuItem<String>(
                                    enabled: false,
                                    value: worldLanguages.keys.elementAt(index),
                                    child: StatefulBuilder(
                                      builder: (context, menuSetState) {
                                        tutorBecome.languages =
                                            widget.languages.join(',');
                                        final isSelected = widget.languages
                                            .contains(worldLanguages.keys
                                                .elementAt(index));
                                        return InkWell(
                                          onTap: () {
                                            isSelected
                                                ? widget.languages.remove(
                                                    worldLanguages.keys
                                                        .elementAt(index))
                                                : widget.languages.add(
                                                    worldLanguages.keys
                                                        .elementAt(index));
                                            menuSetState(() {});
                                            state.didChange(widget.languages);
                                          },
                                          child: isSelected
                                              ? ListTile(
                                                  title: Text(
                                                    worldLanguages.values
                                                        .elementAt(index),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  tileColor: Colors
                                                      .blue.shade100
                                                      .withOpacity(0.4),
                                                  trailing: Icon(
                                                    Icons.check_rounded,
                                                    color: Colors.blue.shade300,
                                                  ),
                                                )
                                              : ListTile(
                                                  title: Text(
                                                    worldLanguages.values
                                                        .elementAt(index),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                hint: Text(_local.selectLanguages),
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
                                  widget.languages.length,
                                  (index) => Chip(
                                    label: Text(worldLanguages[
                                        widget.languages[index]]!),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    side: BorderSide.none,
                                    onDeleted: () {
                                      widget.languages
                                          .remove(widget.languages[index]);
                                      state.didChange(widget.languages);
                                    },
                                    deleteIcon: const Icon(
                                      Icons.cancel_rounded,
                                      size: 18,
                                    ),
                                    backgroundColor:
                                        Colors.grey.shade300.withOpacity(0.4),
                                    deleteButtonTooltipMessage: '',
                                  ),
                                ),
                              ),
                              if (state.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    state.errorText!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                        validator: (value) {
                          if (widget.languages.isEmpty) {
                            return _local.selectLanguagesInputValidator;
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      HeadlineText(textHeadline: _local.whoITeach),
                      const SizedBox(height: 12),
                      HelperText(text: _local.whoITeachInputHint),
                      const SizedBox(height: 12),
                      Text(_local.introduction),
                      TextInput(
                        controller: widget.introductionTextEditingController,
                        isTextArea: true,
                        hintText: _local.introductionInputHint,
                        validator: _local.introductionInputValidator,
                        onChanged: (value) {
                          tutorBecome.bio = value;
                        },
                      ),
                      Text(_local.teachingLevel),
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
                                        groupValue: widget.teachingLevel.first,
                                        onChanged: (value) {
                                          widget.teachingLevel[0] = value!;
                                          state.didChange(value);
                                          tutorBecome.targetStudent = value;
                                        },
                                        title: Text(
                                          level,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
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
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                        validator: (value) {
                          if (widget.teachingLevel.isEmpty) {
                            return _local.teachingLevelInputValidator;
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 12),
                      Text(_local.mySpecialties),
                      FormField(
                        builder: (FormFieldState state) {
                          tutorBecome.specialities = widget.teachingSpecialities
                              .map((speciality) => specialities
                                  .firstWhere(
                                      (element) => element.name == speciality)
                                  .key
                                  .toString())
                              .join(',');
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: specialities
                                    .map((e) => e.name!)
                                    .map<Widget>(
                                      (specialty) => CheckboxListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value: widget.teachingSpecialities
                                            .contains(specialty),
                                        onChanged: (value) {
                                          if (widget.teachingSpecialities
                                              .contains(specialty)) {
                                            widget.teachingSpecialities
                                                .remove(specialty);
                                          } else {
                                            widget.teachingSpecialities
                                                .add(specialty);
                                          }
                                          state.didChange(value);
                                        },
                                        title: Text(
                                          specialty,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
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
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                        validator: (value) {
                          if (widget.teachingSpecialities.isEmpty) {
                            return _local.teachingLevelInputValidator;
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
