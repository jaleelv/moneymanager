import 'package:flutter/material.dart';
import 'package:moneymanager2/screens/category/expense_category_list.dart';
import 'package:moneymanager2/screens/category/income_category_list.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController1;
  @override
  void initState() {
    _tabController1 = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController1,
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
        Container(
          height: 605,
          child: TabBarView(
            controller: _tabController1,
            children: const [
              IncomeCategoryList(),
              ExpenseCategoryList(),
            ],
          ),
        )
      ],
    );
  }
}
