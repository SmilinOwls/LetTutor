import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/widgets/lesson_dialog.dart';

class ScheduleCancelingDialog extends StatefulWidget {
  const ScheduleCancelingDialog({super.key});

  @override
  State<ScheduleCancelingDialog> createState() =>
      _ScheduleCancelingDialogState();
}

class _ScheduleCancelingDialogState extends State<ScheduleCancelingDialog> {
  final TextEditingController _noteTextEditingController =
      TextEditingController();
  final List<String> items = [
    'Reschedule at another time',
    'Busy at that time',
    'Asked by the tutor',
    'Other'
  ];
  String? _selectedValue;
  bool _validate = false;

  @override
  void dispose() {
    super.dispose();
    _noteTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LessonDialog(
      child: Container(
        padding: const EdgeInsets.only(top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'What was the reason you cancel this booking?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 14),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: _selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: 140,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 140,
              child: TextField(
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                controller: _noteTextEditingController,
                onChanged: (value) {
                  setState(() {
                    _validate = value.isEmpty;
                  });
                },
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.all(12),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                  errorText: _validate ?  "The reason cannot be empty!" : null,
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  hintText: 'Additional Note',
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onSubmit: () {
        setState(() {
          _validate = _noteTextEditingController.text.isEmpty;
        });
        if (!_validate) return 'You deleted booking successfully!';
        return null;
      },
    );
  }
}
