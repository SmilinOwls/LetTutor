import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/home/widgets/home_header.dart';
import 'package:lettutor/features/home/widgets/tutor_card.dart';
import 'package:lettutor/features/home/widgets/tutor_search.dart';
import 'package:lettutor/models/tutor/tutor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedNationality;
  String _selectedTag = 'All';

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _nationalityEditingController =
      TextEditingController();
  late final List<Tutor> _tutors;

  @override
  initState() {
    super.initState();
    _tutors = tutors.toList()..sort((tutorLessRating, tutorMoreRating) {
      if (tutorMoreRating.rating == null || tutorLessRating.rating == null) return 0;
      return tutorMoreRating.rating!.compareTo(tutorLessRating.rating!);
    });
  }

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
      _selectedTag = 'All';
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
        children: <Widget>[
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
            itemCount: _tutors.length,
            itemBuilder: (content, index) => TutorCard(
              tutor: _tutors[index],
            ),
          )
        ],
      ),
    );
  }
}
