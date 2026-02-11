enum TransactionType { income, expense }

class TransactionModel {
  final double amount;
  final TransactionType type;
  final DateTime date;

  TransactionModel({
    required this.amount,
    required this.type,
    required this.date,
  });
}
