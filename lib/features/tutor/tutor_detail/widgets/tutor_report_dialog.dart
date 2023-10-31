import 'package:flutter/material.dart';

class TutorReportDiaglog extends StatefulWidget {
  const TutorReportDiaglog({super.key});

  @override
  State<TutorReportDiaglog> createState() => _TutorReportDiaglogState();
}

class _TutorReportDiaglogState extends State<TutorReportDiaglog> {
  final _reportTextEditingController = TextEditingController();
  final Map<String, bool> _reports = {
    'This tutor is annoying me': false,
    'This profile is pretending be someone or is fake': false,
    'Inappropriate profile photo': false
  };

  @override
  void dispose() {
    super.dispose();
    _reportTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.white,
      title: Column(
        children: [
          Text(
            'Report tutor',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 6),
          const Divider(height: 1),
        ],
      ),
      titlePadding: const EdgeInsets.fromLTRB(24, 12, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.report_rounded, color: Colors.blue[700]),
              const SizedBox(width: 4),
              const Text("Help us understand what's happening",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
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
                      });
                    },
                    side: const BorderSide(width: 0.5),
                    activeColor: Colors.blue[500],
                    controlAffinity: ListTileControlAffinity.leading),
              ))),
          SizedBox(
            height: 120,
            child: TextField(
              maxLines: null,
              expands: true,
              keyboardType: TextInputType.multiline,
              controller: _reportTextEditingController,
              onChanged: (value) {},
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              decoration: const InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.all(12),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.5, color: Colors.grey),
                ),
                hintText: 'Please let us know details about your problems',
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.blue),
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
          onPressed: () {
            Navigator.pop(context, true);
          },
          style: TextButton.styleFrom(
              fixedSize: const Size(100, 38),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              backgroundColor: Colors.blue[700]),
          child: const Text(
            'Submit',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
