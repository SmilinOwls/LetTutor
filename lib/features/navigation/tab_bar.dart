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
  final List<String> _tabList = ['Home', 'Tutor', 'Schedule', 'Courses', 'Settings'];

  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(textLeading: _tabList[_activeTab]),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Tutors'),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule_outlined), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
