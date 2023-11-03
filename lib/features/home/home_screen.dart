import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/home/widgets/home_header.dart';
import 'package:lettutor/features/home/widgets/tutor_card.dart';
import 'package:lettutor/features/home/widgets/tutor_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedNationality;
  String _selectedTag = filteredTags[0];

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _nationalityEditingController =
      TextEditingController();

  void _handleNameChange(String value) {
    setState(() {});
  }

  void _handleNationalityChange(String? value) {
    setState(() {
      _selectedNationality = value;
    });
  }

  void _handleTagChange(String value) {
    setState(() {
      _selectedTag = value;
    });
  }

  void _handleFilterReset() {
    setState(() {
      _selectedNationality = null;
      _selectedTag = filteredTags[0];
      _nameEditingController.text = '';
      _nationalityEditingController.text = '';
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameEditingController.dispose();
    _nationalityEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HomeHeader(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(15, 20, 0, 20),
            child: Text(
              'Find a tutor',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          TuTorSearch(
            nameEditingController: _nameEditingController,
            nationalityEditingController: _nationalityEditingController,
            selectedNationality: _selectedNationality,
            selectedTag: _selectedTag,
            onNameChange: _handleNameChange,
            onNationalityChange: _handleNationalityChange,
            onTagChange: _handleTagChange,
            onFilterReset: _handleFilterReset,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(15, 20, 0, 20),
            child: Text(
              'Recommend Tutors',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tutors.length,
            itemBuilder: (content, index) => TutorCard(
              tutor: tutors[index],
            ),
          )
        ],
      ),
    );
  }
}
