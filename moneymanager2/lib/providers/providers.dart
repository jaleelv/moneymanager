import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moneymanager2/models/categories/category_model.dart';
import 'package:moneymanager2/models/transaction/transaction_model.dart';
import 'package:provider/provider.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

class ProviderTotalAmount with ChangeNotifier {
  num? _totalExpense;
  num? _totalIncome;
  num? _balance;

  num? get getTotalExpens => _totalExpense;
  num? get getTotalIncome => _totalIncome;
  num? get getBalance => _balance;
  ProviderTotalAmount._internal();
  static ProviderTotalAmount instance = ProviderTotalAmount._internal();
  factory ProviderTotalAmount() {
    return instance;
  }

  Future<List<TransactionModel>> getTransactions() async {
    final _categoryDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshAmount() async {
    final _allCategories = await getTransactions();

    final filterExpense = _allCategories
        .where((element) => element.category.type.name.startsWith('e'));
    // print(filterExpense.last);

    _totalExpense = filterExpense
        .map((e) => e.amount)
        .reduce((value, element) => value + element);

    final filterIncome = _allCategories
        .where((element) => element.category.type.name.startsWith('i'));

    _totalIncome = filterIncome
        .map((e) => e.amount)
        .reduce((value, element) => value + element);
    // final int result = (_totalIncome as int) - (_totalExpense as int);
    _balance = _totalIncome! - _totalExpense!;

    notifyListeners();
  }
}
