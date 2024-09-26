class TransactionModel {
  final double amount;
  final String category;
  final String description;
  final DateTime date;

  TransactionModel({
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
  });
}
