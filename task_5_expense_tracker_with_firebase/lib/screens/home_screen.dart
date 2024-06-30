import 'package:expense_tracker/const.dart';
import 'package:expense_tracker/screens/expense_screen.dart';
import 'package:expense_tracker/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    ExpenseScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                color: homeProvider.selectedIndex == 0
                    ? AppColors.primaryGreen
                    : Colors.grey.shade300,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: homeProvider.selectedIndex == 1
                    ? AppColors.primaryGreen
                    : Colors.grey.shade300,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: homeProvider.selectedIndex,
          selectedItemColor: AppColors.primaryGreen,
          unselectedItemColor: Colors.grey.shade400,
          onTap: (int index) {
            homeProvider.changeScreen(index);
          },
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
        ),
        body: Center(
          child: _widgetOptions.elementAt(homeProvider.selectedIndex),
        ),
      ),
    );
  }
}
