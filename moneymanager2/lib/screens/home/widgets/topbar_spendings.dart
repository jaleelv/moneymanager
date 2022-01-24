import 'package:flutter/material.dart';

class TopBarSpendings extends StatelessWidget {
  const TopBarSpendings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text('JANUARY'),
          style: ElevatedButton.styleFrom(
              shadowColor: Color(200),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
        ),
      ],
    );
  }
}
