import 'package:flutter/material.dart';
import 'package:moneymanager2/screens/home/home_screen.dart';

class TopBarCategory extends StatelessWidget {
  const TopBarCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: () {},
            child: Text(
              'Edit',
              style: const TextStyle(color: Colors.purple, fontSize: 22),
            )),
        Text(
          'Categories',
          style: TextStyle(color: Colors.purple, fontSize: 22),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              'Sort',
              style: const TextStyle(color: Colors.purple, fontSize: 22),
            )),
        IconButton(
            onPressed: () {
              if (HomeScreen.selectedIndexNotifier.value == 1) {
                print('Add Transaction');
              } else if (HomeScreen.selectedIndexNotifier.value == 2) {
                print('Add Category');
              }
            },
            icon: const Icon(
              Icons.add,
              size: 30,
              color: Colors.purple,
            ))
      ],
    );
  }
}
