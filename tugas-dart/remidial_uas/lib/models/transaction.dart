// transaction.dart
class Transaction {
  final String title;
  final String type;
  final String date;
  final int amount;
  final String description;

  Transaction({
    required this.title,
    required this.type,
    required this.date,
    required this.amount,
    required this.description,
  });
}

// Inisialisasi list kosong di awal
List<Transaction> transactions = [];
