import 'package:flutter/material.dart';
import 'package:moneymanager2/db/category/category_db.dart';
import 'package:moneymanager2/models/categories/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().expenseCategoryListner,
      builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
        return ListView.separated(
          itemBuilder: (BuildContext, Index) {
            final category = newList[Index];

            return Card(
              child: ListTile(
                title: Text(
                  category.name,
                  style: TextStyle(fontSize: 20),
                ),
                trailing: IconButton(
                    onPressed: () {
                      CategoryDB.instance.deleteCategory(category.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ),
            );
          },
          separatorBuilder: (BuildContext, int) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: newList.length,
        );
      },
    );
  }
}
