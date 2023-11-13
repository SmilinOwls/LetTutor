import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.leadingIcon,
      required this.titleText,
      required this.onTap,
      required this.isTrailing});

  final IconData leadingIcon;
  final String titleText;
  final void Function()? onTap;
  final bool isTrailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(104, 175, 175, 175),
          ),
          child: Icon(
            leadingIcon,
            size: 28,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        title: Text(
          titleText,
          style: const TextStyle(fontSize: 18),
        ),
        trailing: isTrailing
            ? const Icon(Icons.keyboard_arrow_right_outlined, size: 28)
            : null,
      ),
    );
  }
}
