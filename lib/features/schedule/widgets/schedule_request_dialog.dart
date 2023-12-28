import 'package:flutter/material.dart';
import 'package:lettutor/models/schedule/booking_info.dart';
import 'package:lettutor/services/booking_service.dart';
import 'package:lettutor/utils/snack_bar.dart';

class SchduleRequestDialog extends StatefulWidget {
  const SchduleRequestDialog({
    super.key,
    required this.booking,
    required this.updateStudentRequest,
  });

  final BookingInfo booking;
  final Function(String) updateStudentRequest;

  @override
  State<SchduleRequestDialog> createState() => _SchduleRequestDialogState();
}

class _SchduleRequestDialogState extends State<SchduleRequestDialog> {
  final TextEditingController _requestTextEditingController =
      TextEditingController();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
    _requestTextEditingController.text = widget.booking.studentRequest ?? '';
  }

  void _handleRequestSubmit() async {
    _validate = _requestTextEditingController.text.isEmpty;
    if (!_validate) {
      await BookingService.handleBookingStudentRequest(
        bookingId: widget.booking.id ?? '',
        studentRequest: _requestTextEditingController.text,
        onSuccess: () {
          widget.updateStudentRequest(_requestTextEditingController.text);
          Navigator.of(context).pop(true);
        },
        onError: (message) => SnackBarHelper.showErrorSnackBar(
          context: context,
          content: message,
        ),
      );
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _requestTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(
        'Special Request',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      titlePadding: const EdgeInsets.only(
        top: 12,
        left: 24,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.4,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Divider(height: 1),
              const SizedBox(height: 16),
              const Text(
                'Note',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: TextField(
                  maxLength: 200,
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  controller: _requestTextEditingController,
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
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    errorText: _validate ? "The reason cannot be empty!" : null,
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.red,
                      ),
                    ),
                    hintText: 'Wish topic (optional)',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
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
              const SizedBox(height: 8),
              const Text(
                'You can write in English or Vietnamese (Maximum 200 letters)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            side: const BorderSide(color: Colors.blue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            'Cancel',
          ),
        ),
        TextButton(
          onPressed: _handleRequestSubmit,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
