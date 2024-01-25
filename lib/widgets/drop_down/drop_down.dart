import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constants/custom/input_decoration.dart';

class DropDownField extends StatelessWidget {
  const DropDownField({
    super.key,
    required this.controller,
    required this.list,
    this.onSelected,
    this.validator,
    this.value,
    this.hintText,
  });

  final TextEditingController controller;
  final Map<String, String> list;
  final String? validator;
  final String? hintText;
  final String? value;
  final void Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 16,
      ),
      child: DropdownButtonFormField2<String>(
        isExpanded: true,
        decoration: customInputDecoration.copyWith(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: -4,
          ),
        ),
        hint: Text(
          hintText ?? '',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        value: value,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        items: List<DropdownMenuItem<String>>.generate(
          list.length,
          (index) => DropdownMenuItem<String>(
            value: list.keys.elementAt(index),
            child: Text(
              list.values.elementAt(index),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validator;
          }
          return null;
        },
        onChanged: (value) {
          controller.text = value!;
          if (onSelected != null) {
            onSelected!(value);
          }
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 8),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down_outlined,
            color: Colors.grey.shade300,
          ),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
