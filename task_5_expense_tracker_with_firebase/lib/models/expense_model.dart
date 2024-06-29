import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final String id;
  final String description;
  final double amount;
  final DateTime createdAt; // Change type to DateTime

  Expense({
    required this.id,
    required this.description,
    required this.amount,
    required this.createdAt,
  });

  factory Expense.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final Timestamp timestamp = data['createdAt'] ?? Timestamp.now();
    final createdAt = timestamp.toDate(); // Convert Timestamp to DateTime
    return Expense(
      id: doc.id,
      description: data['description'] ?? '',
      amount: (data['amount'] ?? 0.0).toDouble(),
      createdAt: createdAt,
    );
  }
}
