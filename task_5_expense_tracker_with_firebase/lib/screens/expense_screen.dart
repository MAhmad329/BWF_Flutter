import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../const.dart';
import '../models/expense_model.dart';
import '../providers/auth_provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_dialog.dart';
import 'login_screen.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  void initState() {
    Provider.of<ExpenseServiceProvider>(context, listen: false)
        .fetchInitialExpenses();
    Provider.of<ExpenseServiceProvider>(context, listen: false).loadExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthServiceProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryGreen,
        onPressed: () {
          _showExpenseDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage('assets/defaultpic.jpg'),
              child: Consumer<AuthServiceProvider>(
                builder: (_, provider, child) {
                  if (provider.user != null && provider.user!.pfp.isNotEmpty) {
                    return CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        provider.user!.pfp,
                      ),
                    );
                  } else {
                    return const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        'assets/defaultpic.jpg',
                      ),
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Text('Hello, ${userProvider.user?.userName}'),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor:
                        Colors.white, // Background color of the dialog
                    title: const Center(
                      child: Text('Confirm'),
                    ),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Colors.grey, // Text color of Cancel button
                        ),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await userProvider.signOut();

                          Future.delayed(Duration.zero, () {
                            Provider.of<ExpenseServiceProvider>(context,
                                    listen: false)
                                .emptyExpenses();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Consumer<ExpenseServiceProvider>(
        builder: (context, expenseProvider, child) {
          final expenses = expenseProvider.expenses;
          if (expenses.isEmpty) {
            return const Center(child: Text('No expenses found'));
          }
          return Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: Rs. ${expenseProvider.totalExpense.toInt().toString()}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Consumer<ExpenseServiceProvider>(
                      builder: (context, expenseProvider, child) {
                        return IconButton(
                          icon: Icon(expenseProvider.isAscending
                              ? Icons.arrow_downward
                              : Icons.arrow_upward),
                          onPressed: () {
                            expenseProvider.toggleSortOrder();
                          },
                        );
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return GestureDetector(
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: const Icon(Icons.edit),
                                    title: const Text('Edit'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _showExpenseDialog(context,
                                          expense: expense);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.delete),
                                    title: const Text('Delete'),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await Provider.of<ExpenseServiceProvider>(
                                              context,
                                              listen: false)
                                          .deleteExpense(expense.id);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: Text(
                            expense.description,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          subtitle: Text(
                            DateFormat.yMMMd().format(expense.createdAt),
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.sp),
                          ),
                          trailing: Text(
                            'Rs. ${expense.amount.toInt().toString()}',
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showExpenseDialog(BuildContext context, {Expense? expense}) {
    showDialog(
      context: context,
      builder: (context) => ExpenseDialog(expense: expense),
    );
  }
}
