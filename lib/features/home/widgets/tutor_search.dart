import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';

class TuTorSearch extends StatelessWidget {
  const TuTorSearch({
    super.key,
    required this.nameEditingController,
    required this.nationalityEditingController,
    required this.selectedNationality,
    required this.selectedTag,
    required this.onNameChange,
    required this.onNationalityChange,
    required this.onTagChange,
    required this.onFilterReset,
  });

  final TextEditingController nameEditingController;

  final TextEditingController nationalityEditingController;
  final String? selectedNationality;
  final String selectedTag;
  final void Function(String) onNameChange;
  final void Function(String?) onNationalityChange;
  final void Function(String) onTagChange;
  final void Function() onFilterReset;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
          child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 6,
              children: [
                SizedBox(
                  width: 150,
                  height: 40,
                  child: TextField(
                    onChanged: onNameChange,
                    controller: nameEditingController,
                    style: const TextStyle(fontSize: 14),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Enter tutor name',
                      filled: true,
                      fillColor: Colors.white70,
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Select tutor',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: tutorNationalies
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedNationality,
                      onChanged: (String? value) {
                        onNationalityChange(value);
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 180,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: nationalityEditingController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextField(
                            expands: true,
                            maxLines: null,
                            controller: nationalityEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for a tutor nationality...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value.toString().toLowerCase().contains(
                                searchValue.toLowerCase(),
                              );
                        },
                      ),
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          nationalityEditingController.clear();
                        }
                      },
                    ),
                  ),
                )
              ]),
        ),
        const SizedBox(width: 8),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 6,
          runSpacing: 8,
          children: filteredTags
              .map<FilterChip>((String tag) => FilterChip(
                    onSelected: (_) {
                      onTagChange(tag);
                    },
                    side: const BorderSide(
                      width: 0,
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: selectedTag == tag
                        ? const Color.fromARGB(255, 221, 234, 255)
                        : const Color.fromARGB(255, 228, 230, 235),
                    label: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedTag == tag
                            ? const Color.fromARGB(255, 0, 113, 240)
                            : const Color.fromARGB(255, 100, 100, 100),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 18),
        OutlinedButton(
          onPressed: onFilterReset,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
          child: Text(
            'Reset Filters',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
