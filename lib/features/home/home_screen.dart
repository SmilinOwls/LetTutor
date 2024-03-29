import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/home/widgets/home_header.dart';
import 'package:lettutor/features/home/widgets/tutor_card.dart';
import 'package:lettutor/features/home/widgets/tutor_search.dart';
import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/services/tutor_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:pager/pager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:collection/collection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.local});

  final AppLocalizations local;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedName;
  String? _selectedNationality;
  String? _selectedTag;

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _nationalityEditingController =
      TextEditingController();
  List<Tutor>? _tutors;

  int _page = 1;
  final int _perPage = 12;
  late int _totalPages;

  @override
  void initState() {
    super.initState();
    _handleSearch();
  }

  // void _getTutors() async {
  //   await TutorService.getListTutorWithPagination(
  //     page: _page,
  //     perPage: _perPage,
  //     onSuccess: (total, tutors, favoriteTutors) {
  //       setState(() {
  //         sortTutorByRating(tutors);
  //         sortTutorByRating(favoriteTutors);
  //         _tutors = [...favoriteTutors, ...tutors];
  //         _filteredTutors = _tutors;
  //         _totalPages = (total / _perPage).ceil();
  //       });
  //     },
  //     onError: (message) => SnackBarHelper.showErrorSnackBar(
  //       context: context,
  //       content: message,
  //     ),
  //   );
  // }

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
    if (_selectedTag != 'All') {
      final tag = specialities
          .firstWhereOrNull((element) => element.name == _selectedTag);
      if (tag != null) {
        specialityList.add(tag.key!);
      }
    }

    Map<String, bool> nationalityList = <String, bool>{};

    int index = tutorNationalities.indexOf(_selectedNationality ?? '');
    switch (index) {
      case 0:
        nationalityList['isVietNamese'] = false;
        nationalityList['isNative'] = false;
        break;
      case 1:
        nationalityList['isVietNamese'] = true;
        break;
      case 2:
        nationalityList['isNative'] = true;
        break;
      default:
        nationalityList = {};
        break;
    }

    await TutorService.searchTutor(
      page: _page,
      perPage: _perPage,
      search: _selectedName ?? '',
      specialties: specialityList,
      nationality: nationalityList,
      onSuccess: (total, tutors) {
        setState(() {
          _totalPages = (total / _perPage).ceil();
          _tutors = tutors.toList()
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

  void _onPageChanged(int page) {
    setState(() {
      _page = page;
    });
    _handleSearch();
  }

  void _handleFilterReset() {
    setState(() {
      _selectedNationality = null;
      _selectedTag = 'All';
      _nameEditingController.text = '';
      _nationalityEditingController.text = '';
    });
    _handleSearch();
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
                HomeHeader(
                  local: widget.local,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(15, 20, 0, 20),
                  child: Text(
                    widget.local.findTutor,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                TuTorSearch(
                  nameEditingController: _nameEditingController,
                  nationalityEditingController: _nationalityEditingController,
                  selectedNationality: _selectedNationality,
                  selectedTag: _selectedTag ?? 'All',
                  onNameChange: _handleNameChange,
                  onNationalityChange: _handleNationalityChange,
                  onTagChange: _handleTagChange,
                  onFilterReset: _handleFilterReset,
                  local: widget.local,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(15, 20, 0, 20),
                  child: Text(
                    widget.local.recommedTutor,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                _tutors!.isNotEmpty
                    ? Column(
                        children: [
                          Pager(
                            currentItemsPerPage: _perPage,
                            currentPage: _page,
                            totalPages: _totalPages,
                            onPageChanged: _onPageChanged,
                          ),
                          const SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _tutors!.length,
                            itemBuilder: (content, index) => TutorCard(
                              key: ValueKey(_tutors![index].userId),
                              tutor: _tutors![index],
                              local: widget.local,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Pager(
                            currentItemsPerPage: _perPage,
                            currentPage: _page,
                            totalPages: _totalPages,
                            onPageChanged: _onPageChanged,
                          ),
                        ],
                      )
                    : Center(
                        child: Column(
                          children: <Widget>[
                            const Icon(
                              Icons.search_off,
                              size: 100,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.local.noTutor,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.local.noTutorDescription,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
              ],
            ),
          );
  }
}
