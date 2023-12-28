import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/features/courses/course_list/widgets/course/course_tab.dart';
import 'package:lettutor/features/courses/course_list/widgets/ebook/ebook_tab.dart';
import 'package:lettutor/services/misc_service.dart';
import 'package:lettutor/utils/snack_bar.dart';
import 'package:lettutor/widgets/drop_down/drop_down.dart';
import 'package:lettutor/widgets/drop_down/multi_choice_drop_down.dart';

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
  
  final List<String> _selectedCategory = [];
  final List<String> _selectedLevel = [];
  final TextEditingController levelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    _getContentCategory();
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

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                'Discover Courses',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              const Text(
                'LiveTutor has built the most quality, methodical and scientific courses'
                'in the fields of life for those who are in need of improving their knowledge of the fields.',
              ),
              const SizedBox(height: 16),
              const Text(
                'Search',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  hintText: 'Search',
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: const Icon(Icons.search),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Level',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              MultiChoiceDropDown(
                items: _levelList,
                selectedItems: _selectedLevel,
                hintText: 'Select level',
              ),
              const SizedBox(height: 12),
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              MultiChoiceDropDown(
                items: _categoryList ?? {},
                selectedItems: _selectedCategory,
                hintText: 'Select category',
              ),
              const SizedBox(height: 12),
              const Text(
                'Level',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              DropDownField(
                controller: levelController,
                list: _sortList,
                hintText: 'Sort by level',
              ),
              const SizedBox(height: 16),
            ],
          ),
        )),
        SliverToBoxAdapter(
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            indicatorColor: Colors.blue[500],
            tabs: const <Widget>[
              Tab(
                child: Text(
                  'Course',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'E-Book',
                  style: TextStyle(
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
          children: const <Widget>[
            // first tab
            CourseTab(),
            // second tab
            EbookTab(),
          ],
        ),
      ),
    );
  }
}
