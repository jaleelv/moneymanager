import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanager2/db/transaction_db.dart';
import 'package:moneymanager2/models/categories/category_model.dart';
import 'package:moneymanager2/models/transaction/transaction_model.dart';
import 'package:moneymanager2/providers/providers.dart';
import 'package:moneymanager2/screens/transactions/add_transaction.dart';
import 'package:moneymanager2/screens/category/add_catogery.dart';
import 'package:moneymanager2/screens/home/home_screen.dart';
import 'package:moneymanager2/screens/transactions/add_transaction.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderTotalAmount(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactonDb(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const HomeScreen(),
        routes: {
          AddCategory.routeName: (ctx) => AddCategory(),
          ScreenAddTransaction.routeName: (ctx) => const ScreenAddTransaction(),
        },
      ),
    );
  }
}
