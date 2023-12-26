import 'package:flutter/material.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:lettutor/utils/snack_bar.dart';

class TutorReportDialog extends StatefulWidget {
  const TutorReportDialog({super.key, required this.tutorId});

  final String tutorId;

  @override
  State<TutorReportDialog> createState() => _TutorReportDialogState();
}

class _TutorReportDialogState extends State<TutorReportDialog> {
  final _reportTextEditingController = TextEditingController();
  final Map<String, bool> _reports = {
    'This tutor is annoying me': false,
    'This profile is pretending be someone or is fake': false,
    'Inappropriate profile photo': false
  };

  void _trackReport() {
    _reports.updateAll((key, value) => false);
    final data = _reportTextEditingController.text.split('\n');
    for (final report in data) {
      if (_reports.containsKey(report)) {
        _reports.update(report, (value) => true);
      }
    }
  }

  void _handleSubmitted() async {
    await TutorService.reportTutor(
      userId: widget.tutorId,
      content: _reportTextEditingController.text,
      onSuccess: () {
        Navigator.pop(context, true);
        SnackBarHelper.showSuccessSnackBar(
          context: context,
          content: 'Report successfully',
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

  @override
  void dispose() {
    super.dispose();
    _reportTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Column(
        children: <Widget>[
          Text(
            'Report tutor',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 6),
          const Divider(height: 1),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.report_rounded, color: Colors.blue[700]),
              const SizedBox(width: 4),
              const Text(
                "Help us understand what's happening",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: List<Widget>.generate(
                _reports.length,
                (index) => CheckboxListTile(
                  title: Text(
                    _reports.keys.elementAt(index),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  value: _reports.values.elementAt(index),
                  onChanged: (value) {
                    setState(() {
                      _reports.update(
                          _reports.keys.elementAt(index), (value) => !value);
                      if (_reports.values.elementAt(index)) {
                        _reportTextEditingController.text =
                            '${_reportTextEditingController.text}${_reports.keys.elementAt(index)}\n';
                      } else {
                        _reportTextEditingController.text =
                            _reportTextEditingController.text.replaceAll(
                                '${_reports.keys.elementAt(index)}\n', '');
                      }
                    });
                  },
                  side: const BorderSide(width: 0.5, color: Colors.blue),
                  activeColor: Colors.blue[500],
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 120,
            child: TextField(
              maxLines: null,
              expands: true,
              keyboardType: TextInputType.multiline,
              controller: _reportTextEditingController,
              onChanged: (value) {
                _trackReport();
              },
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
                hintText: 'Please let us know details about your problems',
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(100, 38),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            side: BorderSide(
              width: 1.5,
              color: Colors.blue[700]!,
            ),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blue[700],
            ),
          ),
        ),
        TextButton(
          onPressed: _handleSubmitted,
          style: TextButton.styleFrom(
            fixedSize: const Size(100, 38),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.blue[700],
          ),
          child: const Text(
            'Submit',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
