// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:moneymanager2/models/categories/category_model.dart';
import 'package:moneymanager2/models/transaction/transaction_model.dart';
import 'package:provider/provider.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

class ProviderTotalAmount with ChangeNotifier {
  double? totalExpense;
  double? totalIncome;

  Future<List<TransactionModel>> getTransactions() async {
    final _categoryDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshAmount() async {
    final _allCategories = await getTransactions();

    final filterExpense = _allCategories
        .where((element) => element.category.type.name.startsWith('e'));

    totalExpense = filterExpense.map((e) => e.amount).reduce((value, element) {
      return value + element;
    });

    final filterIncome = _allCategories
        .where((element) => element.category.type.name.startsWith('i'));

    totalIncome = filterIncome.map((e) => e.amount).reduce((value, element) {
      return value + element;
    });
    notifyListeners();
    print('object $totalExpense');
  }

  // double amount = refreshAmount (vale);

  // final amount = refreshAmount();
}
