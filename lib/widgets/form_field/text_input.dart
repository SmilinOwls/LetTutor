import 'package:flutter/material.dart';
import 'package:lettutor/constants/custom/input_decoration.dart';
import 'package:lettutor/utils/input_decoration_merge.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.controller,
    this.isReadOnly,
    this.isDisabled,
    this.validator,
    this.hintText,
    this.isTextArea,
    this.inputDecoration,
    this.onTap,
    this.onChanged,
  });

  final TextEditingController controller;
  final bool? isReadOnly;
  final bool? isDisabled;
  final String? validator;
  final String? hintText;
  final bool? isTextArea;
  final InputDecoration? inputDecoration;
  final void Function()? onTap;
  final void Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 16,
      ),
      child: TextFormField(
        controller: controller,
        autocorrect: false,
        readOnly: isReadOnly ?? false,
        keyboardType: TextInputType.text,
        decoration: MergeInputDecoration.merge(customInputDecoration, inputDecoration).copyWith(
              hintMaxLines: 3,
              isDense: isTextArea == null ? true : false,
              hintText: hintText,
              filled: isDisabled ?? false,
              fillColor: isDisabled == null
                  ? null
                  : Colors.grey.shade300.withOpacity(0.3),
            ),
        maxLines: isTextArea ?? false ? null : 1,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validator;
          }
          return null;
        },
        onTap: onTap,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
