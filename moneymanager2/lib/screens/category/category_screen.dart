import 'package:flutter/material.dart';
import 'package:moneymanager2/db/category/category_db.dart';
import 'package:moneymanager2/models/categories/category_model.dart';
import 'package:moneymanager2/screens/category/add_catogery.dart';
import 'package:moneymanager2/screens/category/expense_category_list.dart';
import 'package:moneymanager2/screens/category/income_category_list.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController1;

  @override
  void initState() {
    tabController1 = TabController(length: 2, vsync: this);

    CategoryDB.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 0,
          child: TabBar(
            onTap: (index) {
              AddCategory.selectedTypeNotifier.value = index;
            },
            controller: tabController1,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.purple),
            tabs: const [
              Tab(
                text: 'INCOME',
              ),
              Tab(
                text: 'EXPENSE',
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            // height: 700,
            child: TabBarView(
              controller: tabController1,
              children: [
                Column(
                  children: [
                    Expanded(child: IncomeCategoryList()),
                  ],
                ),
                Column(
                  children: [
                    Expanded(child: ExpenseCategoryList()),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
