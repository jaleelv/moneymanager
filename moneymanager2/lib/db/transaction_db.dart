import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanager2/models/categories/category_model.dart';
import 'package:moneymanager2/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactonDbFunctions {
  Future<void> addtransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(String id);
}

class TransactonDb implements TransactonDbFunctions {
  TransactonDb._internal();
  static TransactonDb instance = TransactonDb._internal();
  factory TransactonDb() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);
  ValueNotifier<double> totalIncomeListNotifier = ValueNotifier(0);
  ValueNotifier<double> totalExpenseListNotifier = ValueNotifier(0);
  @override
  Future<void> addtransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getAllTransactions();
    double? _totalAmount = 0.0;

    _list.sort((first, second) => second.date.compareTo(first.date));

    await Future.forEach(
      _list,
      (TransactionModel category) {
        if (category.type == CategoryType.income) {
          final IncomeTotal = _list
              .map((e) => e.amount)
              .reduce((value, element) => value + element);
          totalIncomeListNotifier.value = IncomeTotal;
        } else {
          final ExpenseTotal = _list
              .map((e) => e.amount)
              .reduce((value, element) => value + element);
          totalExpenseListNotifier.value = ExpenseTotal;
        }
      },
    );

    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);

    transactionListNotifier.notifyListeners();
    // final _amt = _list.forEach((element) {

    // });
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }
}
