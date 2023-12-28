import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/constants/custom/input_decoration.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/account/user/profile/widgets/custom_label.dart';
import 'package:lettutor/models/misc/learn_topic.dart';
import 'package:lettutor/models/misc/test_preparation.dart';
import 'package:lettutor/models/user/user.dart';
import 'package:lettutor/providers/auth/auth_provider.dart';
import 'package:lettutor/services/user_service.dart';
import 'package:lettutor/utils/media_picker.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/bar/app_bar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ValueNotifier<String?>? _imageData;

  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _countryTextEditingController =
      TextEditingController();
  final TextEditingController _phoneNumberTextEditingController =
      TextEditingController();
  final TextEditingController _birthdayTextEditingController =
      TextEditingController();
  final TextEditingController _levelTextEditingController =
      TextEditingController();
  final TextEditingController _studyScheduleTextEditingController =
      TextEditingController();

  late final List<LearnTopic> _learnTopics;
  late final List<TestPreparation> _testPreparations;
  List<String> _selectedDesiredLearningItems = [];

  final List<Map<String, dynamic>> _desiredLearningData =
      <Map<String, dynamic>>[
    for (final item in desiredLearningContent)
      for (final value in item.values)
        if (value is List)
          for (final listValue in value)
            {
              'value': listValue.name!,
              'isTitled': false,
            }
        else
          {
            'value': value,
            'isTitled': true,
          }
  ];

  void _getAccountInfo() async {
    await UserService.getUserInfo(
      onSuccess: (user) {
        _imageData = ValueNotifier(user.avatar);
        _nameTextEditingController.text = user.name ?? '';
        _emailTextEditingController.text = user.email ?? '';
        _countryTextEditingController.text = user.country ?? '';
        _phoneNumberTextEditingController.text = user.phone ?? '';
        _birthdayTextEditingController.text = user.birthday ?? '';
        _levelTextEditingController.text = user.level ?? '';
        _learnTopics = user.learnTopics ?? [];
        _testPreparations = user.testPreparations ?? [];
        _selectedDesiredLearningItems = [
          ..._learnTopics.map((e) => e.name!),
          ..._testPreparations.map((e) => e.name!),
        ];
        _studyScheduleTextEditingController.text = user.studySchedule ?? '';
      },
      onError: (message) => SnackBarHelper.showErrorSnackBar(
        context: context,
        content: message,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getAccountInfo();
  }

  void _onAvatarSubmited() async {
    File? imageData = await pickerImage(ImageSource.gallery);
    if (imageData != null) {
      _imageData?.value = imageData.path;
      await UserService.uploadImage(
        image: imageData,
        onSuccess: (user){
          _imageData?.value = user.avatar;
          context.read<AuthProvider>().setUser(user);
        },
        onError: (message) {
          SnackBarHelper.showErrorSnackBar(
            context: context,
            content: message,
          );
        },
      );
    }
  }

  void _onDateChanged(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(_birthdayTextEditingController.text == ''
          ? DateFormat('yyyy-MM-dd').format(DateTime.now())
          : _birthdayTextEditingController.text),
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

  void _onProfileChangeSubmited() async {
    if (_formKey.currentState!.validate()) {
      await UserService.updateInfo(
        updateUser: User(
          name: _nameTextEditingController.text,
          country: _countryTextEditingController.text,
          birthday: _birthdayTextEditingController.text,
          level: _levelTextEditingController.text,
          learnTopics: subjects
              .where((learnTopic) =>
                  _selectedDesiredLearningItems.contains(learnTopic.name))
              .toList(),
          testPreparations: testPreparations
              .where((testPreparation) =>
                  _selectedDesiredLearningItems.contains(testPreparation.name))
              .toList(),
          studySchedule: _studyScheduleTextEditingController.text,
        ),
        onSuccess: (user) {
          context.read<AuthProvider>().setUser(user!);
          SnackBarHelper.showSuccessSnackBar(
            context: context,
            content: 'Your profile has been updated.',
          );
        },
        onError: (message) {
          SnackBarHelper.showErrorSnackBar(
            context: context,
            content: message,
          );
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _countryTextEditingController.dispose();
    _phoneNumberTextEditingController.dispose();
    _birthdayTextEditingController.dispose();
    _levelTextEditingController.dispose();
    _studyScheduleTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().getUser();

    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: 'Profile',
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(
                color: Colors.blue.shade800,
                width: 4,
              ),
            )),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ValueListenableBuilder<String?>(
                        valueListenable: _imageData ?? ValueNotifier(''),
                        builder: (context, value, child) => Container(
                          width: 140,
                          height: 140,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            value ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person_rounded, size: 62),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        width: 32,
                        child: InkWell(
                          onTap: _onAvatarSubmited,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            child: const Icon(
                              Icons.edit_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Text(
                        user?.name ?? '',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Account ID: ${user?.id ?? ''}',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Others review you',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Change password',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade600.withOpacity(0.8),
                        width: 0.3,
                      ),
                    ),
                    color: Colors.grey.shade300.withOpacity(0.3),
                  ),
                  child: const Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 16),
                        const CustomLabel(label: 'Name'),
                        TextFormField(
                          controller: _nameTextEditingController,
                          autocorrect: false,
                          keyboardType: TextInputType.name,
                          decoration: customInputDecoration.copyWith(
                            hintText: 'Enter your name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please input your name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 20),
                        const CustomLabel(
                          label: 'Email Address',
                          isRequired: false,
                        ),
                        TextFormField(
                          controller: _emailTextEditingController,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          readOnly: true,
                          decoration: customInputDecoration.copyWith(
                            filled: true,
                            fillColor: Colors.grey.shade300.withOpacity(0.3),
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 20),
                        const CustomLabel(label: 'Country'),
                        DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: customInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: -4,
                            ),
                          ),
                          value: countryList.keys
                                  .contains(_countryTextEditingController.text)
                              ? _countryTextEditingController.text
                              : null,
                          items: List.generate(
                            countryList.length,
                            (index) => DropdownMenuItem<String>(
                              value: countryList.keys.elementAt(index),
                              child: Text(
                                countryList.values.elementAt(index),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a country';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            _countryTextEditingController.text = value!;
                          },
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
                        const SizedBox(height: 20),
                        const CustomLabel(label: 'Phone Number'),
                        TextFormField(
                          controller: _phoneNumberTextEditingController,
                          autocorrect: false,
                          readOnly: true,
                          keyboardType: TextInputType.phone,
                          decoration: customInputDecoration.copyWith(
                            filled: true,
                            fillColor: Colors.grey.shade300.withOpacity(0.3),
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Chip(
                          label: const Text('Verified'),
                          labelStyle: const TextStyle(color: Colors.green),
                          side: BorderSide(
                            color: Colors.green.shade200.withOpacity(0.8),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          backgroundColor:
                              Colors.green.shade100.withOpacity(0.2),
                        ),
                        const SizedBox(height: 20),
                        const CustomLabel(label: 'Birthday'),
                        TextFormField(
                          controller: _birthdayTextEditingController,
                          autocorrect: false,
                          decoration: customInputDecoration.copyWith(
                            suffixIcon: Icon(
                              Icons.calendar_month_outlined,
                              size: 20,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          onTap: () {
                            _onDateChanged(context);
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select your birthday';
                            }
                            return null;
                          },
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 20),
                        const CustomLabel(label: 'My level'),
                        DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: customInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: -4,
                            ),
                          ),
                          value: studentLevels.keys
                                  .contains(_levelTextEditingController.text)
                              ? _levelTextEditingController.text
                              : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          items: List<DropdownMenuItem<String>>.generate(
                            studentLevels.length,
                            (index) => DropdownMenuItem<String>(
                              value: studentLevels.keys.elementAt(index),
                              child: Text(
                                studentLevels.values.elementAt(index),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select your level';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _levelTextEditingController.text = value!;
                          },
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
                        const SizedBox(height: 20),
                        const CustomLabel(label: 'Want to learn'),
                        DropdownButtonFormField2(
                          isExpanded: true,
                          decoration: customInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: -4,
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          items: List<DropdownMenuItem>.generate(
                            _desiredLearningData.length,
                            (index) => _desiredLearningData[index]['isTitled']
                                ? DropdownMenuItem(
                                    enabled: false,
                                    value: _desiredLearningData[index]['value'],
                                    child: Text(
                                      _desiredLearningData[index]['value'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                : DropdownMenuItem(
                                    enabled: false,
                                    value: _desiredLearningData[index]['value'],
                                    child: StatefulBuilder(
                                      builder: (context, menuSetState) {
                                        final isSelected =
                                            _selectedDesiredLearningItems
                                                .contains(
                                                    _desiredLearningData[index]
                                                        ['value']);
                                        return InkWell(
                                          onTap: () {
                                            isSelected
                                                ? _selectedDesiredLearningItems
                                                    .remove(
                                                        _desiredLearningData[
                                                            index]['value'])
                                                : _selectedDesiredLearningItems
                                                    .add(_desiredLearningData[
                                                        index]['value']);
                                            setState(() {});
                                            menuSetState(() {});
                                          },
                                          child: isSelected
                                              ? ListTile(
                                                  title: Text(
                                                    _desiredLearningData[index]
                                                        ['value'],
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
                                                    _desiredLearningData[index]
                                                        ['value'],
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
                          validator: (value) {
                            if (value == null) {
                              return 'Please select at least one subject.';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          value: _selectedDesiredLearningItems.isEmpty
                              ? null
                              : _selectedDesiredLearningItems.last,
                          selectedItemBuilder: (context) => _desiredLearningData
                              .map<Widget>(
                                (item) => Wrap(
                                  spacing: 4,
                                  runSpacing: 8,
                                  children: List<Widget>.generate(
                                    _selectedDesiredLearningItems.length,
                                    (index) => Chip(
                                      label: Text(
                                          _selectedDesiredLearningItems[index]),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      side: BorderSide.none,
                                      onDeleted: () {
                                        setState(() {
                                          _selectedDesiredLearningItems
                                              .remove(item['value']);
                                        });
                                      },
                                      deleteIcon: const Icon(
                                        Icons.cancel_rounded,
                                        size: 18,
                                      ),
                                      backgroundColor:
                                          Colors.grey.shade300.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                            height: 180,
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
                        const SizedBox(height: 20),
                        const CustomLabel(
                          label: 'Study Schedule',
                          isRequired: false,
                        ),
                        SizedBox(
                          height: 150,
                          child: TextFormField(
                            controller: _studyScheduleTextEditingController,
                            expands: true,
                            maxLines: null,
                            autocorrect: false,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: customInputDecoration.copyWith(
                              hintText:
                                  'Note the time of the week you want to study on LetTutor',
                            ),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _onProfileChangeSubmited,
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue.shade700,
                              padding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 20,
                              ),
                            ),
                            child: const Text(
                              'Save changes',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
