import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/expense_model.dart';

class ExpenseServiceProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late User? _user;
  List<Expense> _expenses = [];
  bool _isAscending = true;

  List<Expense> get expenses {
    _expenses.sort((a, b) => _isAscending
        ? a.createdAt.compareTo(b.createdAt)
        : b.createdAt.compareTo(a.createdAt));
    return _expenses;
  }

  bool get isAscending => _isAscending;

  double get totalExpense => _expenses.fold(
      0, (sumOfExpenses, expense) => sumOfExpenses + expense.amount);

  Future<void> loadExpenses() async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      CollectionReference expensesCollectionRef =
          _db.collection('users').doc(_user!.uid).collection('expenses');
      expensesCollectionRef.snapshots().listen((snapshot) {
        _expenses =
            snapshot.docs.map((doc) => Expense.fromFirestore(doc)).toList();
        notifyListeners();
      });
    }
  }

  Future<void> fetchInitialExpenses() async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      CollectionReference expensesCollectionRef =
          _db.collection('users').doc(_user!.uid).collection('expenses');
      QuerySnapshot snapshot = await expensesCollectionRef.get();
      _expenses =
          snapshot.docs.map((doc) => Expense.fromFirestore(doc)).toList();
      notifyListeners();
    }
  }

  Future<void> addExpense(
      String description, double amount, DateTime createdAt) async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      DocumentReference userDocRef = _db.collection('users').doc(_user!.uid);
      CollectionReference expensesCollectionRef =
          userDocRef.collection('expenses');

      await expensesCollectionRef.add({
        'description': description,
        'amount': amount.roundToDouble(),
        'createdAt':
            Timestamp.fromDate(createdAt), // Store createdAt as Timestamp
      });
    }
  }

  void emptyExpenses() {
    _expenses = [];
  }

  Future<void> deleteExpense(String id) async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      CollectionReference expensesCollectionRef =
          _db.collection('users').doc(_user!.uid).collection('expenses');

      await expensesCollectionRef.doc(id).delete();
    }
  }

  Future<void> updateExpense(
      String id, String description, double amount, DateTime createdAt) async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      CollectionReference expensesCollectionRef =
          _db.collection('users').doc(_user!.uid).collection('expenses');

      await expensesCollectionRef.doc(id).update({
        'description': description,
        'amount': amount.roundToDouble(),
        'createdAt':
            Timestamp.fromDate(createdAt), // Update createdAt as Timestamp
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  void toggleSortOrder() {
    _isAscending = !_isAscending;
    notifyListeners();
  }
}
