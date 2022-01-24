import 'package:flutter/material.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext, Index) {
        return Card(
          child: ListTile(
            title: Text('Income category $Index'),
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
