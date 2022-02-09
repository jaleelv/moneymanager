import 'package:flutter/material.dart';
import 'package:moneymanager2/db/transaction_db.dart';
import 'package:moneymanager2/models/categories/category_model.dart';
import 'package:moneymanager2/models/transaction/transaction_model.dart';
import 'package:moneymanager2/providers/providers.dart';
import 'package:provider/provider.dart';

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
                  Text(
                    'Income',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Consumer<ProviderTotalAmount>(
                      builder: (context, value, Widget) {
                    value.refreshAmount();
                    final incomeAmount = value.getTotalIncome.toString();
                    return Text(
                      incomeAmount,
                      style: TextStyle(fontSize: 22, color: Colors.green),
                    );
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Expense',
                    style: TextStyle(fontSize: 22),
                  ),
                  Consumer<ProviderTotalAmount>(
                      builder: (context, value, Widget) {
                    value.refreshAmount();
                    final expenseAmount = value.getTotalExpens.toString();
                    return Text(
                      expenseAmount,
                      style: TextStyle(fontSize: 22, color: Colors.red),
                    );
                  }),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Consumer<TransactonDb>(builder: (_, transactionData, __) {
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
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (_, index) {
                    final _value = mergedExpense[index];

                    return Card(
                      elevation: 0,
                      child: ListTile(
                        style: ListTileStyle.list,
                        title: Text(
                          _value.category.name,
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: Text('RS ${_value.amount}',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(
                      height: 1,
                    );
                  },
                  itemCount: mergedExpense.length,
                );
              }),
            ],
          ),
          Container(
            height: 133,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '-------------------------------------------------------------',
                      style: TextStyle(fontSize: 22),
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
                      final balance = value.getBalance.toString();
                      return Text(
                        balance,
                        style: TextStyle(fontSize: 22),
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
