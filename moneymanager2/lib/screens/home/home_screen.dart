import 'package:flutter/material.dart';
import 'package:moneymanager2/screens/category/category_screen.dart';
import 'package:moneymanager2/screens/home/widgets/bottom_navigation.dart';
import 'package:moneymanager2/screens/spendings/spendings_screen.dart';
import 'package:moneymanager2/screens/transactions/transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [
    SpendingsScreen(),
    TransactonScreen(),
    CategoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
          child: Column(
        children: [
          // TopBar(),
          ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (BuildContext context, int updatedIndex, _) {
              return _pages[updatedIndex];
            },
          ),
        ],
      )),
    );
  }
}
