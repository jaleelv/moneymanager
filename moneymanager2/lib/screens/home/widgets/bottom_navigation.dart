import 'package:flutter/material.dart';
import 'package:moneymanager2/screens/home/home_screen.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return Container(
          color: Colors.purple.shade50,
          child: BottomNavigationBar(
              selectedItemColor: Colors.purple,
              unselectedItemColor: Colors.grey,
              currentIndex: updatedIndex,
              onTap: (newIndex) {
                HomeScreen.selectedIndexNotifier.value = newIndex;
                HomeScreen.selectedIndexNotifierTopbar.value = newIndex;
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.ac_unit), label: 'Spendings'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Transactions'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Categories'),
                // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              ]),
        );
      },
    );
  }
}
