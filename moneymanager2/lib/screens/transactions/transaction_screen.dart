import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager2/db/category/category_db.dart';
import 'package:moneymanager2/db/transaction_db.dart';
import 'package:moneymanager2/models/categories/category_model.dart';
import 'package:moneymanager2/models/transaction/transaction_model.dart';

class TransactonScreen extends StatelessWidget {
  const TransactonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Text('data');

    return ValueListenableBuilder(
      valueListenable: TransactonDb.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.green.shade100,
                  child: Text(
                    "Income",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.red.shade100,
                  child: Text(
                    "Expense",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ],
            ),

            // Container(color: Colors.amber, child: TopBarCategory()),
            Container(
              height: 573,
              child: ListView.separated(
                // shrinkWrap: true,
                padding: EdgeInsets.all(10),
                itemBuilder: (ctx, index) {
                  final _value = newList[index];
                  return Slidable(
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (ctx) {
                            TransactonDb.instance.deleteTransaction(_value.id!);
                          },
                          icon: Icons.delete,
                          label: 'Delete',
                        )
                      ],
                    ),
                    key: Key(_value.id!),
                    child: Card(
                      child: ListTile(
                        // leading: Text(_value.category.name),
                        title: Text(_value.category.name),
                        subtitle: Text(parseDate(_value.date)),
                        trailing: Text(
                          _value.amount.toString(),
                          style: TextStyle(
                            color: _value.type == CategoryType.income
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
                itemCount: newList.length,
              ),
            ),
          ],
        );
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.yMMMEd().format(date);

    final _splitedDate = _date.split(' ');

    return '${_splitedDate[0]}${_splitedDate[2]}${_splitedDate[1]}${_splitedDate[3]}';
    // return _date;
  }
}
