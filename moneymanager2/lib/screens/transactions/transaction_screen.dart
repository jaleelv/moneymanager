import 'package:flutter/material.dart';

class TransactonScreen extends StatelessWidget {
  const TransactonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Text('data');

    return Column(
      children: [
        // Container(color: Colors.amber, child: TopBarCategory()),
        Container(
          height: 605,
          child: ListView.separated(
            // shrinkWrap: true,
            padding: EdgeInsets.all(10),
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
            itemCount: 8,
          ),
        ),
      ],
    );
  }
}
