import 'package:flutter/material.dart';
import 'package:moneymanager2/db/transaction_db.dart';
import 'package:moneymanager2/models/transaction/transaction_model.dart';
import 'package:moneymanager2/providers/providers.dart';
import 'package:provider/provider.dart';
import 'dart:ffi';

class SpendingsScreen extends StatelessWidget {
  const SpendingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Income', style: TextStyle(fontSize: 22)),
                  Consumer<ProviderTotalAmount>(builder: (context, value, _) {
                    value.refreshAmount();
                    final incomeAmount = value.getTotalIncome;
                    return Text(incomeAmount.toStringAsFixed(2),
                        style: TextStyle(fontSize: 22, color: Colors.green));
                  }),
                ],
              ),
              //----------------------------------------------------------------------------------

              SizedBox(
                height: 15,
              ),
              // ------------------------------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Expense', style: TextStyle(fontSize: 22)),
                  Consumer<ProviderTotalAmount>(builder: (context, value, _) {
                    value.refreshAmount();
                    final expenseAmount = value.getTotalExpens;
                    return Text(
                      expenseAmount.toStringAsFixed(2),
                      style: TextStyle(fontSize: 22, color: Colors.red),
                    );
                  }),
                ],
              ),
            ],
          ),
          Expanded(
            child: Consumer<TransactonDb>(builder: (_, transactionData, __) {
              transactionData.refresh();
              final data = transactionData.getListData;

              var mergedCategories = <String, TransactionModel>{};
              for (TransactionModel transactionModel in data) {
                var purpose = transactionModel.category.name;
                var amount = transactionModel.amount;
                (mergedCategories[purpose] ??= TransactionModel(
                  type: transactionModel.type,
                  date: transactionModel.date,
                  amount: 0,
                  purpose: transactionModel.category.name,
                  category: transactionModel.category,
                ))
                    .amount += amount;
              }
              List<TransactionModel> mergedList = [];
              mergedCategories.forEach((key, value) => mergedList.add(
                  TransactionModel(
                      type: value.type,
                      date: value.date,
                      amount: value.amount,
                      purpose: value.category.name,
                      category: value.category)));
              // final mergedExpense = mergedList
              //     .where((element) => element.category.name.contains('Food'))
              //     .toList();
              final mergedExpense = mergedList
                  .where(
                      (element) => element.category.type.name.startsWith('e'))
                  .toList();

              // TransactonDb.instance.refresh();
              // transactionData.refresh();
              return ListView.separated(
                // shrinkWrap: true,
                padding: const EdgeInsets.all(5),
                itemBuilder: (_, index) {
                  final _value = mergedExpense[index];

                  return mergedExpense.length < index
                      ? Text('data')
                      : ListTile(
                          style: ListTileStyle.list,
                          title: Text(
                            _value.category.name,
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: Text(
                            'RS ${_value.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        );
                  // Text('abcd');
                },
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 1,
                  );
                },
                itemCount: mergedExpense.length,
              );
            }),
          ),
          // Expanded(
          //   flex: 10,
          //   child: Container(
          //     // height: 200,
          //     color: Colors.red,
          //   ),
          // )
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '-------------------------------------------------------',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Balance',
                      style: TextStyle(fontSize: 22),
                    ),
                    Consumer<ProviderTotalAmount>(
                        builder: (context, value, Widget) {
                      value.refreshAmount();

                      final balance = value.getBalance.toStringAsFixed(2);
                      return Text(
                        'RS $balance',
                        style:
                            TextStyle(fontSize: 22, color: Colors.blueAccent),
                      );
                    })
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
