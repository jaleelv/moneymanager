import 'package:flutter/material.dart';
import 'package:moneymanager2/db/category/category_db.dart';
import 'package:moneymanager2/db/transaction_db.dart';
import 'package:moneymanager2/providers/providers.dart';
import 'package:moneymanager2/screens/category/category_screen.dart';
import 'package:moneymanager2/screens/category/topbar_category.dart';
import 'package:moneymanager2/screens/home/widgets/bottom_navigation.dart';
import 'package:moneymanager2/screens/home/widgets/topbar_spendings.dart';
import 'package:moneymanager2/screens/transactions/topbar_transaction.dart';
import 'package:moneymanager2/screens/spendings/spendings_screen.dart';
import 'package:moneymanager2/screens/transactions/transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  static ValueNotifier<int> selectedIndexNotifierTopbar = ValueNotifier(0);
  final _pages = const [
    SpendingsScreen(),
    TransactonScreen(),
    CategoryScreen(),
  ];
  final _topbar = const [
    TopBarSpendings(),
    TopBarTransaction(),
    TopBarCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    TransactonDb.instance.refresh();
    CategoryDB.instance.refreshUI();
    ProviderTotalAmount.instance.refreshAmount();
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 0,
            child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifierTopbar,
              builder: (BuildContext context1, int updatedTopbar, _) {
                // print(_topbar[updatedIndex]);
                return _topbar[updatedTopbar];
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext context, int updatedIndex, _) {
                return _pages[updatedIndex];
              },
            ),
          ),
        ],
      )),
    );
  }
}
