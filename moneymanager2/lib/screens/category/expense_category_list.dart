import 'package:flutter/material.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext, Index) {
        return Card(
          child: ListTile(
            title: Text('Expense category $Index'),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
          ),
        );
      },
      separatorBuilder: (BuildContext, int) {
        return const SizedBox(
          height: 10,
        );
      },
      itemCount: 10,
    );
  }
}
