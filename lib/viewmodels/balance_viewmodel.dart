import 'package:expense_trackker/model/notes_model.dart';
import 'package:flutter/material.dart';


class BalanceViewModel extends ChangeNotifier {
  double _balance = 0;
  final List<NoteModel> _notes = [];

  double get balance => _balance;
  List<NoteModel> get notes => List.unmodifiable(_notes);

  void addIncome(double amount, {String? description}) {
    _balance += amount;
    _notes.insert(
      0,
      NoteModel(
        text: description == null || description.isEmpty
            ? "Income added: Rs. $amount"
            : "Income: Rs. $amount - $description",
        isIncome: true,
      ),
    );
    notifyListeners();
  }

  void addExpense(double amount, {String? description}) {
    _balance -= amount;
    _notes.insert(
      0,
      NoteModel(
        text: description == null || description.isEmpty
            ? "Expense added: Rs. $amount"
            : "Expense: Rs. $amount - $description",
        isIncome: false,
      ),
    );
    notifyListeners();
  }
}
