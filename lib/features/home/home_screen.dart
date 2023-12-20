import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/home/widgets/home_header.dart';
import 'package:lettutor/features/home/widgets/tutor_card.dart';
import 'package:lettutor/features/home/widgets/tutor_search.dart';
import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:lettutor/utils/snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedName;
  String? _selectedNationality;
  String _selectedTag = 'All';

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _nationalityEditingController =
      TextEditingController();
  List<Tutor>? _tutors;
  List<Tutor>? _filteredTutors;

  @override
  void initState() {
    super.initState();
    _getTutors();
  }

  void _getTutors() async {
    await TutorService.getListTutorWithPagination(
      page: 1,
      perPage: 10,
      onSuccess: (tutors, favoriteTutors) {
        setState(() {
          sortTutorByRating(tutors);
          sortTutorByRating(favoriteTutors);
          _tutors = [...favoriteTutors, ...tutors];
          _filteredTutors = _tutors;
        });
      },
      onError: (message) => SnackBarHelper.showErrorSnackBar(
        context: context,
        content: message,
      ),
    );
  }

  void sortTutorByRating(List<Tutor> tutors) {
    tutors = tutors
      ..sort((tutorLessRating, tutorMoreRating) {
        if (tutorMoreRating.rating == null || tutorLessRating.rating == null) {
          return 0;
        }
        return tutorMoreRating.rating!.compareTo(tutorLessRating.rating!);
      });
  }

  void _handleNameChange(String value) {
    _selectedName = value;
    _handleSearch();
    setState(() {});
  }

  void _handleNationalityChange(String? value) {
    _selectedNationality = value;
    _handleSearch();
    setState(() {});
  }

  void _handleTagChange(String value) {
    _selectedTag = value;
    _handleSearch();
    setState(() {});
  }

  void _handleSearch() async {
    List<String> specialityList = <String>[];
    if (_selectedTag != '' && _selectedTag != 'All') {
      final tag =
          specialities.firstWhere((element) => element.name == _selectedTag);
      specialityList.add(tag.key!);
    }

    Map<String, bool> nationalityList = <String, bool>{};

    switch (_selectedNationality) {
      case 'Foreign Tutor':
        nationalityList['isVietNamese'] = false;
        nationalityList['isNative'] = false;
        break;
      case 'Vietnamese Tutor':
        nationalityList['isVietNamese'] = true;
        break;
      case 'Native English Tutor':
        nationalityList['isNative'] = true;
        break;
      default:
        nationalityList = {};
        break;
    }

    await TutorService.searchTutor(
      page: 1,
      perPage: 10,
      search: _selectedName ?? '',
      specialties: specialityList,
      nationality: nationalityList,
      onSuccess: (tutors) {
        setState(() {
          _filteredTutors = tutors.toList()
            ..sort((tutorLessRating, tutorMoreRating) {
              if (tutorMoreRating.rating == null ||
                  tutorLessRating.rating == null) return 0;
              return tutorMoreRating.rating!.compareTo(tutorLessRating.rating!);
            });
        });
      },
      onError: (message) => SnackBarHelper.showErrorSnackBar(
        context: context,
        content: message,
      ),
    );
  }

  void _handleFilterReset() {
    setState(() {
      _selectedNationality = null;
      _selectedTag = 'All';
      _nameEditingController.text = '';
      _nationalityEditingController.text = '';
      _filteredTutors = _tutors;
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
    return _tutors == null
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
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
                  itemCount: _filteredTutors!.length,
                  itemBuilder: (content, index) => TutorCard(
                    tutor: _filteredTutors![index],
                  ),
                )
              ],
            ),
          );
  }
}
