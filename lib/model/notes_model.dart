class NoteModel {
  final String title;
  final String description;
  final double amount;
  final bool isIncome;

  NoteModel({
    required this.title,
    required this.description,
    required this.amount,
    required this.isIncome,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'amount': amount,
      'isIncome': isIncome,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'],
      description: map['description'],
      amount: map['amount'],
      isIncome: map['isIncome'],
    );
  }
}
