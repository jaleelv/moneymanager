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
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Edit',
                        style:
                            const TextStyle(color: Colors.purple, fontSize: 22),
                      )),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('JANUARY'),
                    style: ElevatedButton.styleFrom(
                        shadowColor: Color(200),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  IconButton(
                      onPressed: () {
                        if (selectedIndexNotifier.value == 1) {
                          print('Add Transaction');
                        } else if (selectedIndexNotifier.value == 2) {
                          print('Add Category');
                        }
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.purple,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Sort',
                        style:
                            const TextStyle(color: Colors.purple, fontSize: 22),
                      )),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.chevron_left,
                      size: 30,
                      color: Colors.purple,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.chevron_right,
                      size: 30,
                      color: Colors.purple,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.purple,
                      ))
                ],
              ),
            ],
          ),
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
