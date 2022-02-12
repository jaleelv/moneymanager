import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanager2/models/categories/category_model.dart';
import 'package:moneymanager2/models/transaction/transaction_model.dart';
import 'package:moneymanager2/providers/providers.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactonDbFunctions {
  Future<void> addtransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(String id);
}

class TransactonDb with ChangeNotifier implements TransactonDbFunctions {
  List<TransactionModel> _listData = [];
  List<TransactionModel> get getListData => _listData;
  List<TransactionModel> filterExpense = [];
  List<TransactionModel> get filtercategory => filterExpense;
  List<TransactionModel> distinctList = [];
  List<TransactionModel> get distinctCategory => distinctList;
  TransactonDb._internal();
  static TransactonDb instance = TransactonDb._internal();
  factory TransactonDb() {
    return instance;
  }

  @override
  Future<void> addtransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
    notifyListeners();
  }

  Future<void> refresh() async {
    _listData = await getAllTransactions();
    filterExpense = _listData
        .where((element) => element.category.type.name.startsWith('e'))
        .toList();
    // distinctList = filterExpense.sublist(1);

    // print(filterExpense.toString());

    // final filterData = _listData
    // .where((element) => element.category.type.name.startsWith('e'));

    // final  _listDataMonth = _listData.where((element) =>element.date.month);
    // var now_1m = new DateTime(now.year, now.month-1, now.day);

    filterExpense.sort((a, b) =>
        (a.category.name).toString().compareTo((b.category.name).toString()));
    _listData.sort((first, second) => second.date.compareTo(first.date));

    notifyListeners();
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
    ProviderTotalAmount.instance.refreshAmount();
  }

  void getMonth(List data) {
    for (final record in data) {
      final _monthOfRecord = record
          .date.month; // Gives the month number. January = 1, April = 4, etc.
      // Do other stuff, based on the current monthNumber
      switch (_monthOfRecord) {
        case 1:
          'JANUARY';
          break;

        default:
          break;
      }
    }
  }
}
