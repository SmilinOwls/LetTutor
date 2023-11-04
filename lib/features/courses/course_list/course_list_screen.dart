import 'package:flutter/material.dart';
import 'package:lettutor/features/courses/course_list/widgets/course.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              const Icon(Icons.school_rounded, size: 62),
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
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
            Course(),
            // second tab
            Course(),
          ],
        ),
      ),
    );
  }
}
