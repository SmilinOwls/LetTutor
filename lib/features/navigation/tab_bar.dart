import 'package:flutter/material.dart';
import 'package:lettutor/features/home/home_screen.dart';
import 'package:lettutor/widgets/app_bar.dart';

class TabBarNavigator extends StatefulWidget {
  const TabBarNavigator({super.key});

  @override
  State<TabBarNavigator> createState() => _TabBarNavigatorState();
}

class _TabBarNavigatorState extends State<TabBarNavigator> {
  List<Widget> screens = [
    const HomeScreen(),
  ];

  final Map<String, IconData> _tabList = {
    'Home': Icons.home,
    'Tutor': Icons.people,
    'Schedule': Icons.schedule_outlined,
    'Courses': Icons.school,
    'Setting': Icons.settings,
  };

  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(textLeading: _tabList.keys.elementAt(_activeTab)),
      body: screens[_activeTab],
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
          currentIndex: _activeTab,
          items: _tabList.entries
              .map<BottomNavigationBarItem>((MapEntry entry) =>
                  BottomNavigationBarItem(label: entry.key, icon: Icon(entry.value)))
              .toList()),
    );
  }
}
