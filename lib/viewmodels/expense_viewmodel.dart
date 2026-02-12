import 'package:expense_trackker/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseViewModel extends ChangeNotifier {
  final List<ExpenseModel> _transactions = [];

  List<ExpenseModel> get transactions => _transactions;

  void addTransaction(String title, double amount, TransactionType type) {
    _transactions.add(
      ExpenseModel(
        title: title,
        amount: amount,
        date: DateTime.now(),
        type: type,
      ),
    );
    notifyListeners();
  }

  double get totalExpense => _transactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0, (sum, t) => sum + t.amount);

  double get totalLoan => _transactions
      .where((t) => t.type == TransactionType.loan)
      .fold(0, (sum, t) => sum + t.amount);

  double get totalBorrow => _transactions
      .where((t) => t.type == TransactionType.borrow)
      .fold(0, (sum, t) => sum + t.amount);
}
