import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/widgets/lesson_dialog.dart';

class HistoryReportDialog extends StatefulWidget {
  const HistoryReportDialog({super.key});

  @override
  State<HistoryReportDialog> createState() => _HistoryReportDialogState();
}

const List<String> reasons = [
  'Tutor was late',
  'Tutor was absent',
  'Network unstable',
  'Other'
];

class _HistoryReportDialogState extends State<HistoryReportDialog> {
  final TextEditingController _noteTextEditingController =
      TextEditingController();
  String _selectedValue = reasons.first;

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
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    'Select Reason',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: reasons
                      .map(
                        (String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  value: _selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
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
                controller: _noteTextEditingController,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {},
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                decoration: const InputDecoration(
                  isCollapsed: true,
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'Additional Notes',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onSubmit: () {
        return 'You deleted booking successfully!';
      },
    );
  }
}
