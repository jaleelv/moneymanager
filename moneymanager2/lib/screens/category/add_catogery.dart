import 'package:flutter/material.dart';
import 'package:moneymanager2/db/category/category_db.dart';
import 'package:moneymanager2/models/categories/category_model.dart';
import 'package:moneymanager2/screens/category/category_screen.dart';
import 'package:moneymanager2/screens/category/income_category_list.dart';

class AddCategory extends StatelessWidget {
  static const routeName = 'add-transaction';
  AddCategory({Key? key}) : super(key: key);
  final _nameEdittingController = TextEditingController();
  static ValueNotifier<int> selectedTypeNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  Text(
                    'New Category',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        final newType = selectedTypeNotifier.value;
                        final _name = _nameEdittingController.text;
                        if (_name.isEmpty) {
                          return;
                        }
                        final _type;

                        if (newType == 0) {
                          _type = CategoryType.income;
                        } else {
                          _type = CategoryType.expense;
                        }

                        final _category = CategoryModel(
                            id: DateTime.now()
                                .microsecondsSinceEpoch
                                .toString(),
                            name: _name,
                            type: _type);
                        CategoryDB.instance.insertCategory(_category);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              TextFormField(
                controller: _nameEdittingController,
                decoration: InputDecoration(
                  hintText: 'Enter Category',
                ),
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
