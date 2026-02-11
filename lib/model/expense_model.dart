enum TransactionType { expense, loan, borrow, income }

class ExpenseModel {
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
  });
}
