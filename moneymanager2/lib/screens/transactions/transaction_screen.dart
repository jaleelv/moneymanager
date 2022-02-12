import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager2/db/transaction_db.dart';
import 'package:moneymanager2/models/categories/category_model.dart';
import 'package:moneymanager2/providers/providers.dart';
import 'package:provider/provider.dart';

class TransactonScreen extends StatelessWidget {
  const TransactonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('reloaded');
    // Provider.of<ProviderTotalAmount>(context, listen: false).getListData;
    // return Text('data');

    return Column(
      children: [
        Container(
          height: 30,
          color: Colors.purple.shade50,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                color: Colors.green,
                child: Center(
                  // child: Text('Expense', style: TextStyle(fontSize: 20)),
                  child: Consumer<ProviderTotalAmount>(
                    builder: (_, value, __) {
                      value.refreshAmount();
                      final totalAmount =
                          value.getTotalIncome.toStringAsFixed(2);
                      return Text(totalAmount, style: TextStyle(fontSize: 20));
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red,
                child: Center(
                  child: Consumer<ProviderTotalAmount>(
                    builder: (_, value, __) {
                      final totalAmount =
                          value.getTotalExpens.toStringAsFixed(2);
                      return Text(totalAmount, style: TextStyle(fontSize: 20));
                    },
                  ),
                  // child: Text('Expense', style: TextStyle(fontSize: 20)),
                ),
              ),
            )
          ],
        ),

        Expanded(
          flex: 2,
          child: Consumer<TransactonDb>(builder: (_, transactionData, __) {
            // TransactonDb.instance.refresh();
            transactionData.refresh();
            return ListView.separated(
              padding: const EdgeInsets.all(5),
              itemBuilder: (_, index) {
                final _value = transactionData.getListData[index];

                return Slidable(
                  key: Key(_value.id!),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
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
                  child: ListTile(
                    style: ListTileStyle.list,
                    title: Text(
                      _value.category.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      parseDate(_value.date),
                    ),
                    trailing: Text('RS ${_value.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          color: _value.type == CategoryType.income
                              ? Colors.green
                              : Colors.red,
                        )),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 1,
                );
              },
              itemCount: transactionData.getListData.length,
            );
          }),
        ),

        // --------------------------------------------------------------------------------//
        // Listview widget
      ],
    );
  }

// -----------------------------------------------------------------------------------------//
  String parseDate(DateTime date) {
    final _date = DateFormat.yMMMEd().format(date);

    final _splitedDate = _date.split(' ');

    return '${_splitedDate[0]}${_splitedDate[2]}${_splitedDate[1]}${_splitedDate[3]}';
    // return _date;
  }

  // double getTotalAmount(double totalAmount) {}

}
