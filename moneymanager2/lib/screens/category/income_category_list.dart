import 'package:flutter/material.dart';
import 'package:moneymanager2/db/category/category_db.dart';
import 'package:moneymanager2/models/categories/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB.instance.incomeCategoryListner,
      builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
        return ListView.separated(
          itemBuilder: (BuildContext ctx, int index) {
            final category = newList[index];
            return Card(
              child: ListTile(
                title: Text(category.name),
                trailing: IconButton(
                    onPressed: () {
                      CategoryDB.instance.deleteCategory(category.id);
                    },
                    icon: Icon(Icons.delete)),
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
