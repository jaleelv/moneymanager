import 'package:flutter/material.dart';
import 'package:moneymanager2/db/category/category_db.dart';
import 'package:moneymanager2/models/categories/category_model.dart';
import 'package:moneymanager2/screens/category/add_catogery.dart';
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
              Navigator.of(context).pushNamed(AddCategory.routeName);
              // if (HomeScreen.selectedIndexNotifier.value == 1) {
              //   print('Add Transaction');
              // } else if (HomeScreen.selectedIndexNotifier.value == 2) {
              //   print('Add Category');
              //   final _sample = CategoryModel(
              //     id: DateTime.now().microsecondsSinceEpoch.toString(),
              //     name: 'Travel',
              //     type: CategoryType.expense,
              //   );
              //   CategoryDB().insertCategory(_sample);
              // }
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
