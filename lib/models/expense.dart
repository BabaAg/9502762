
class Expense {
  final double amount;
  final String category;
  final String description;
  final DateTime date;

  Expense({
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
  });

  String toJson() {
    return '$amount|$category|$description|${date.toIso8601String()}';
  }

  static Expense fromJson(String str) {
    final parts = str.split('|');
    return Expense(
      amount: double.parse(parts[0]),
      category: parts[1],
      description: parts[2],
      date: DateTime.parse(parts[3]),
    );
  }
}
