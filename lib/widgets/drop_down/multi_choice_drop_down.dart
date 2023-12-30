import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constants/custom/input_decoration.dart';

class MultiChoiceDropDown extends StatefulWidget {
  const MultiChoiceDropDown({
    super.key,
    required this.items,
    required this.selectedItems,
    this.onSelected,
    this.hintText = '',
    this.validator = false,
  });

  final Map<String, String> items;
  final List<String> selectedItems;
  final void Function(List<String>)? onSelected;
  final String hintText;
  final bool validator;

  @override
  State<MultiChoiceDropDown> createState() => _MultiChoiceDropDownState();
}

class _MultiChoiceDropDownState extends State<MultiChoiceDropDown> {
  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final selectedItems = widget.selectedItems;

    return FormField(
      builder: (FormFieldState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: customInputDecoration.copyWith(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: -4,
                ),
              ),
              items: List<DropdownMenuItem<String>>.generate(
                items.length,
                (index) => DropdownMenuItem<String>(
                  enabled: false,
                  value: items.keys.elementAt(index),
                  child: StatefulBuilder(
                    builder: (context, menuSetState) {
                      final isSelected =
                          selectedItems.contains(items.keys.elementAt(index));
                      return InkWell(
                        onTap: () {
                          isSelected
                              ? selectedItems
                                  .remove(items.keys.elementAt(index))
                              : selectedItems.add(items.keys.elementAt(index));

                          if (widget.onSelected != null) {
                            widget.onSelected!(selectedItems);
                          }

                          menuSetState(() {});
                          state.didChange(selectedItems);
                        },
                        child: isSelected
                            ? ListTile(
                                title: Text(
                                  items.values.elementAt(index),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                tileColor:
                                    Colors.blue.shade100.withOpacity(0.4),
                                trailing: Icon(
                                  Icons.check_rounded,
                                  color: Colors.blue.shade300,
                                ),
                              )
                            : ListTile(
                                title: Text(
                                  items.values.elementAt(index),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ),
              hint: Text(
                widget.hintText,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onChanged: (value) {},
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
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 8,
              children: List<Widget>.generate(
                selectedItems.length,
                (index) => Chip(
                  label: Text(items[selectedItems[index]]!),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  side: BorderSide.none,
                  onDeleted: () {
                    selectedItems.remove(selectedItems[index]);
                    if (widget.onSelected != null) {
                      widget.onSelected!(selectedItems);
                    }
                    state.didChange(selectedItems);
                  },
                  deleteIcon: const Icon(
                    Icons.cancel_rounded,
                    size: 18,
                  ),
                  backgroundColor: Colors.grey.shade300.withOpacity(0.4),
                  deleteButtonTooltipMessage: '',
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  state.errorText!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
          ],
        );
      },
      validator: (value) {
        if (widget.validator && selectedItems.isEmpty) {
          return 'Please input at least one item!';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
