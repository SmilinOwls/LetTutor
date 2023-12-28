import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/widgets/dialog/lesson_dialog.dart';

class ScheduleCancelingDialog extends StatefulWidget {
  const ScheduleCancelingDialog({super.key, required this.booking});

  final BookingInfo booking;

  @override
  State<ScheduleCancelingDialog> createState() =>
      _ScheduleCancelingDialogState();
}

const reasons = [
  'Reschedule at another time',
  'Busy at that time',
  'Asked by the tutor',
  'Other'
];

class _ScheduleCancelingDialogState extends State<ScheduleCancelingDialog> {
  final TextEditingController _noteTextEditingController =
      TextEditingController();
  String _selectedReason = reasons.first;

  Future<bool?> _handleCancelSubmit() async {
    final response = await BookingService.cancelBooking(
      cancelReasonId: reasons.indexOf(_selectedReason) + 1,
      cancelNote: _noteTextEditingController.text.isEmpty
          ? null
          : _noteTextEditingController.text,
      scheduleDetailId: widget.booking.id ?? '',
    );

    return response;
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
                  'Select Item',
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
                value: _selectedReason,
                onChanged: (String? value) {
                  setState(() {
                    _selectedReason = value!;
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
              keyboardType: TextInputType.multiline,
              controller: _noteTextEditingController,
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
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      onSubmit: () async {
        final response = await _handleCancelSubmit();
        return response.toString();
      },
    );
  }
}
