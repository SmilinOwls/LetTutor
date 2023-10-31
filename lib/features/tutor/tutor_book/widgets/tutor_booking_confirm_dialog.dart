import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TutorBookingConfirmDialog extends StatefulWidget {
  const TutorBookingConfirmDialog({super.key, required this.schedule});

  final Map<String, dynamic> schedule;

  @override
  State<TutorBookingConfirmDialog> createState() =>
      _TutorBookingConfirmDialogState();
}

class _TutorBookingConfirmDialogState extends State<TutorBookingConfirmDialog> {
  final TextEditingController _requestTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _requestTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            'Book This Tutor',
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 6,
          ),
          const Divider(height: 1),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Booking time',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 6),
            Text(
              widget.schedule['hour'],
              style: TextStyle(fontSize: 18, color: Colors.blue[700]),
              textAlign: TextAlign.center,
            ),
            Text(
              DateFormat('yyyy-MM-dd').format(widget.schedule['date']),
              style: TextStyle(fontSize: 18, color: Colors.blue[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Note',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 120,
              child: TextField(
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                controller: _requestTextEditingController,
                decoration: const InputDecoration(
                  isCollapsed: true,
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'Your requests for the tutor',
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          style: OutlinedButton.styleFrom(
              fixedSize: const Size(100, 38),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              side: BorderSide(width: 1.5, color: Colors.blue[700]!)),
          child: Text(
            'Cancel',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blue[700]),
          ),
        ),
        TextButton(
            onPressed: () async {
              if (mounted) {
                Navigator.pop(context, true);
                Navigator.pop(context, true);
              }
            },
            style: TextButton.styleFrom(
                fixedSize: const Size(100, 38),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.blue[700]),
            child: const Text(
              'BOOK',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )),
      ],
    );
  }
}
