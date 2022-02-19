import 'package:flutter/material.dart';
import 'package:moneymanager2/screens/transactions/add_transaction.dart';
import 'package:moneymanager2/screens/home/home_screen.dart';

class TopBarTransaction extends StatelessWidget {
  const TopBarTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'Edit',
                  style: const TextStyle(color: Colors.grey, fontSize: 22),
                )),
            ElevatedButton(
              onPressed: () {},
              child: Text(''),
              style: ElevatedButton.styleFrom(
                  shadowColor: Color(200),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(ScreenAddTransaction.routeName);
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.purple,
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'Sort',
                  style: const TextStyle(color: Colors.grey, fontSize: 22),
                )),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.chevron_left,
                size: 30,
                color: Colors.purple,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.chevron_right,
                size: 30,
                color: Colors.purple,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Export',
                style: const TextStyle(color: Colors.grey, fontSize: 22),
              ),
            )
          ],
        ),
      ],
    );
  }
}
