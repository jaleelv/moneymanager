import 'package:flutter/material.dart';
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
                  style: const TextStyle(color: Colors.purple, fontSize: 22),
                )),
            ElevatedButton(
              onPressed: () {},
              child: Text('JANUARY'),
              style: ElevatedButton.styleFrom(
                  shadowColor: Color(200),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            IconButton(
                onPressed: () {
                  if (HomeScreen.selectedIndexNotifier.value == 1) {
                    print('Add Transaction');
                  } else if (HomeScreen.selectedIndexNotifier.value == 2) {
                    print('Add Category');
                  }
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
                  style: const TextStyle(color: Colors.purple, fontSize: 22),
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
                style: const TextStyle(color: Colors.purple, fontSize: 22),
              ),
            )
          ],
        ),
      ],
    );
  }
}
