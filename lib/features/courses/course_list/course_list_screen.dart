import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/courses/course_list/widgets/course/course_tab.dart';
import 'package:lettutor/features/courses/course_list/widgets/ebook/ebook_tab.dart';
import 'package:lettutor/services/misc_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/drop_down/drop_down.dart';
import 'package:lettutor/widgets/drop_down/multi_choice_drop_down.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Map<String, String>? _categoryList;
  final Map<String, String> _levelList = coursesLevel;
  final Map<String, String> _sortList = coursesLevelSort;

  final TextEditingController _searchController = TextEditingController();
  final List<String> _selectedCategory = [];
  final List<String> _selectedLevel = [];
  final TextEditingController _levelController = TextEditingController();

  final ValueNotifier<Map<String, dynamic>> _searchList = ValueNotifier({});
  late AppLocalizations _local;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    _getContentCategory();
    _searchList.value = {
      'search': _searchController.text,
      'categoryId': _selectedCategory,
      'level': _selectedLevel,
      'orderBy': _levelController.text,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context);
  }

  void _getContentCategory() async {
    await MiscService.getCategory(
      onSuccess: (levelList) {
        setState(() {
          _categoryList = {};
          for (final level in levelList) {
            _categoryList![level.id!] = level.title!;
          }
        });
      },
      onError: (message) {
        SnackBarHelper.showErrorSnackBar(
          context: context,
          content: message,
        );
      },
    );
  }

  void _onSearchChanged(String value) {
    _searchList.value = {
      ..._searchList.value,
      'search': value,
    };
  }

  void _onLevelChanged(List<String> value) {
    _searchList.value = {
      ..._searchList.value,
      'level': value,
    };
  }

  void _onCategoryChanged(List<String> value) {
    _searchList.value = {
      ..._searchList.value,
      'categoryId': value,
    };
  }

  void _onLevelSortChanged(String value) {
    _searchList.value = {
      ..._searchList.value,
      'orderBy': value,
    };
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _tabController.dispose();
    _levelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl:
                          'https://sandbox.app.lettutor.com/static/media/course.0bf1bb71.svg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.school_rounded,
                        size: 62,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _local.discoverCourses,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _local.coursesDescription,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  _local.searchCourses,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _searchController,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    hintText: _local.searchCourses,
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: const Icon(Icons.search),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _local.level,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                MultiChoiceDropDown(
                  items: _levelList,
                  selectedItems: _selectedLevel,
                  hintText: _local.levelSelectHint,
                  onSelected: _onLevelChanged,
                ),
                const SizedBox(height: 12),
                Text(
                  _local.category,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                MultiChoiceDropDown(
                  items: _categoryList ?? {},
                  selectedItems: _selectedCategory,
                  hintText: _local.categorySelectHint,
                  onSelected: _onCategoryChanged,
                ),
                const SizedBox(height: 12),
                Text(
                  _local.sort,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                DropDownField(
                  controller: _levelController,
                  list: _sortList,
                  hintText: _local.sortSelectHint,
                  onSelected: _onLevelSortChanged,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            indicatorColor: Colors.blue[500],
            tabs: <Widget>[
              Tab(
                child: Text(
                  _local.courses,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  _local.eBook,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            // first tab
            ValueListenableBuilder(
              valueListenable: _searchList,
              builder: (context, value, child) {
                final searchs = value;
                return CourseTab(
                  searchs: searchs,
                  key: ValueKey(searchs),
                  // searchs is updated -> force widget rebuild
                );
              },
            ),
            // second tab
            ValueListenableBuilder(
              valueListenable: _searchList,
              builder: (context, value, child) {
                final searchs = value;
                return EbookTab(
                  searchs: searchs,
                  key: ValueKey(searchs),
                  // searchs is updated -> force widget rebuild
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
