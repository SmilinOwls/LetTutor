import 'package:flutter/material.dart';

class ApprovalStep extends StatelessWidget {
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
        const Text('You have done all the steps'),
        const SizedBox(height: 8),
        const Text('Please, wait for the operator\'s approval'),
      ],
    );
  }
}
