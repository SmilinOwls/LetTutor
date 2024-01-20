import 'package:flutter/material.dart';
import 'package:lettutor/utils/localization.dart';

class ApprovalStep extends StatelessWidget with Localization {
  const ApprovalStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.tag_faces_outlined,
          color: Theme.of(context).primaryColor,
          size: 100,
        ),
        const SizedBox(height: 16),
        Text(Localization.local!.allStepsDone),
        const SizedBox(height: 8),
        Text(Localization.local!.waitForApproval),
      ],
    );
  }
}
