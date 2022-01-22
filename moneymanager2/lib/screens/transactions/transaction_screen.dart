import 'package:flutter/material.dart';

class TransactonScreen extends StatelessWidget {
  const TransactonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 605,
      child: ListView.separated(
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              leading: Text('12 dec'),
              title: Text('1000'),
              subtitle: Text('Category Name'),
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return const SizedBox(
            height: 5,
          );
        },
        itemCount: 10,
      ),
    );
  }
}
