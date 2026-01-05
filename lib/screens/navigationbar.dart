import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/screens/nottificationpage.dart';
import 'package:amore_student_erp/screens/profilepage.dart';
import 'package:amore_student_erp/screens/welcomepage.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});

  @override
  _NavigationbarState createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int _currentPage = 0;
  final _pageController = PageController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [Welcomepage(), Notificationpage(), profile_page()],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: const <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.dashboard_outlined),
            title: Text('Dashboard'),
            activeColor: Appcolor.selectionblue,
            // activeTitleColor: Colors.blue.shade600,
          ),
          BottomBarItem(
            icon: Icon(Icons.notifications_none),
            title: Text('Nottification'),
            activeColor: Appcolor.selectionblue,
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            activeColor: Appcolor.selectionblue,
          ),
        ],
      ),
    );
  }
}
