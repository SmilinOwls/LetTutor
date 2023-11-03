import 'package:flutter/material.dart';

class CustomHeadline extends StatelessWidget {
  const CustomHeadline({super.key, required this.textHeadline});

  final String textHeadline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 30,
            child: Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            textHeadline,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
