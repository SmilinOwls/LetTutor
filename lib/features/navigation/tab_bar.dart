import 'package:flutter/material.dart';
import 'package:lettutor/features/home/home_screen.dart';
import 'package:lettutor/widgets/app_bar.dart';

class TabBarNavigator extends StatefulWidget {
  const TabBarNavigator({super.key});

  @override
  State<TabBarNavigator> createState() => _TabBarNavigatorState();
}

class _TabBarNavigatorState extends State<TabBarNavigator> {  
  final List<Map<String, dynamic>> _tabList = [
    {
      'label': 'Home', 
      'icon': Icons.home, 
      'screen': const HomeScreen()
    },
    {
      'label': 'Tutor', 
      'icon': Icons.people, 
      'screen': const HomeScreen()
    },
    {
      'label': 'Schedule', 
      'icon': Icons.schedule_outlined, 
      'screen': const HomeScreen()
    },
    {
      'label': 'Courses', 
      'icon': Icons.school, 
      'screen': const HomeScreen()
    },
    {
      'label': 'Settings', 
      'icon': Icons.settings, 
      'screen': const HomeScreen()
    },
  ];

  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: _tabList[_activeTab]['label']),
      body: _tabList[_activeTab]['screen'],
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
          items: _tabList
              .map<BottomNavigationBarItem>((Map tab) =>
                  BottomNavigationBarItem(
                      label: tab['label'], icon: Icon(tab['icon'])))
              .toList()),
    );
  }
}