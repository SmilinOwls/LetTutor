import 'package:flutter/material.dart';
import 'package:lettutor/features/account/account_screen.dart';
import 'package:lettutor/features/courses/course_list/course_list_screen.dart';
import 'package:lettutor/features/history/history_screen.dart';
import 'package:lettutor/features/home/home_screen.dart';
import 'package:lettutor/features/schedule/schedule_screen.dart';
import 'package:lettutor/utils/localization.dart';
import 'package:lettutor/widgets/bar/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabBarNavigator extends StatefulWidget {
  const TabBarNavigator({super.key});

  @override
  State<TabBarNavigator> createState() => _TabBarNavigatorState();
}

class _TabBarNavigatorState extends State<TabBarNavigator> {
  late AppLocalizations _local;
  late List<Map<String, dynamic>> _tabList;
  int? _activeTab;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _local = AppLocalizations.of(context)!;
    _activeTab = 0;
    _tabList = [
      {
        'label': _local.home,
        'icon': Icons.home,
        'screen': HomeScreen(
          local: _local,
        ),
      },
      {
        'label': _local.schedule,
        'icon': Icons.calendar_month_rounded,
        'screen': const ScheduleScreen(),
      },
      {
        'label': _local.history,
        'icon': Icons.history_outlined,
        'screen': const HistoryScreen(),
      },
      {
        'label':  _local.courses,
        'icon': Icons.school,
        'screen': const CourseListScreen(),
      },
      {
        'label': _local.account,
        'icon': Icons.person_outlined,
        'screen': const AccountScreen(),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    Localization.initialize(context);

    if(_activeTab == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(appBarTitle: _tabList[_activeTab!]['label']),
      body: _tabList[_activeTab!]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (value) {
          setState(() {
            _activeTab = value;
          });
        },
        elevation: 18,
        currentIndex: _activeTab!,
        items: _tabList
            .map<BottomNavigationBarItem>(
              (Map tab) => BottomNavigationBarItem(
                label: tab['label'],
                icon: Icon(
                  tab['icon'],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
