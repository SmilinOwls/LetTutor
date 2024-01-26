import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/widgets/dialog/lesson_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryReportDialog extends StatefulWidget {
  const HistoryReportDialog({super.key, required this.booking});

  final BookingInfo booking;

  @override
  State<HistoryReportDialog> createState() => _HistoryReportDialogState();
}

class _HistoryReportDialogState extends State<HistoryReportDialog> {
  final TextEditingController _noteTextEditingController =
      TextEditingController();

  late AppLocalizations _local;
  late final List<String> _reasons;
  late String _selectedValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
    _reasons = _local.lessonReportingReasons.split(':');
    _selectedValue = _reasons.first;
  }

  @override
  void dispose() {
    super.dispose();
    _noteTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LessonDialog(
      booking: widget.booking,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            _local.reportLessonTitle,
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
                  _local.selectReason,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: _reasons
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
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(12),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                ),
                hintText: _local.additionalNote,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
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
      onSubmit: () async {
        return await Future<String>.value(_local.sentLessonReport);
      },
    );
  }
}
