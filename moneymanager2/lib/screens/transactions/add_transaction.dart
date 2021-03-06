import 'package:flutter/material.dart';
import 'package:moneymanager2/db/category/category_db.dart';
import 'package:moneymanager2/db/transaction_db.dart';
import 'package:moneymanager2/models/categories/category_model.dart';
import 'package:moneymanager2/models/transaction/transaction_model.dart';
import 'package:moneymanager2/screens/transactions/transaction_screen.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction>
    with SingleTickerProviderStateMixin {
  // String? dateToday;
  late TabController tabController;
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;

  final _amountEdittingController = TextEditingController();
  final _categoryEdittingController = TextEditingController();
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    _selectedCategoryType = CategoryType.income;
    // _selectedDate = TransactonScreen().parseDate(DateTime.now()) as DateTime?;
    _selectedDate = DateTime.now();
    // dateToday = TransactonScreen().parseDate(DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Text(
                      "New Transaction",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {
                        addTransaction();
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TabBar(
                      onTap: (index) {
                        setState(() {
                          _categoryID = null;
                          if (index == 0) {
                            _selectedCategoryType = CategoryType.income;
                          } else {
                            _selectedCategoryType = CategoryType.expense;
                          }
                        });
                      },
                      controller: tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.purple),
                      tabs: const [
                        Tab(text: 'INCOME'),
                        Tab(text: 'EXPENSE'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            TextButton.icon(
              onPressed: () async {
                final _selectedDateTemp = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 30)),
                  lastDate: DateTime.now(),
                );
                if (_selectedDateTemp == null) {
                  return;
                } else {
                  setState(() {
                    _selectedDate = _selectedDateTemp;
                  });
                }
              },
              icon: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              label: Text(
                _selectedDate == null
                    ? TransactonScreen().parseDate(DateTime.now())
                    : TransactonScreen().parseDate(_selectedDate!),
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextFormField(
              controller: _amountEdittingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Amount'),
            ),
            TextFormField(
              readOnly: true,
              controller: _categoryEdittingController,
              decoration: InputDecoration(hintText: 'Select Category'),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButton(
              hint: Text(
                'Select Category',
                style: TextStyle(fontSize: 20),
              ),
              value: _categoryID,
              items: (_selectedCategoryType == CategoryType.income
                      ? CategoryDB.instance.incomeCategoryListner
                      : CategoryDB.instance.expenseCategoryListner)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(
                    e.name,
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    _selectedCategoryModel = e;

                    // final _category=_selectedCategoryModel.name;
                    _categoryEdittingController.text = e.name;
                  },
                );
              }).toList(),
              onChanged: (selectedValue) {
                print(selectedValue);
                setState(() {
                  _categoryID = selectedValue as String?;
                });
              },
            ),
          ],
        ),
      )),
    );
  }

  Future<void> addTransaction() async {
    final _amountText = _amountEdittingController.text;
    final _categoryText = _categoryEdittingController.text;
    if (_selectedCategoryModel == null) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_categoryText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }
    final _model = TransactionModel(
      type: _selectedCategoryType!,
      date: _selectedDate!,
      amount: _parsedAmount,
      purpose: _categoryText,
      category: _selectedCategoryModel!,
    );
    // print('date  $_model.date');

    await TransactonDb.instance.addtransaction(_model);
    Navigator.of(context).pop();
    TransactonDb.instance.refresh();
  }
}
