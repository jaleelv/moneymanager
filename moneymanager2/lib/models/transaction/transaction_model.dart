import 'package:hive/hive.dart';
import 'package:moneymanager2/models/categories/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final CategoryType type;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final String purpose;
  @HiveField(4)
  final CategoryModel category;
  @HiveField(5)
  String? id;

  TransactionModel({
    required this.type,
    required this.date,
    required this.amount,
    required this.purpose,
    required this.category,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
