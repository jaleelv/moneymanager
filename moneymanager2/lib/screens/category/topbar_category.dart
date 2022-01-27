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
