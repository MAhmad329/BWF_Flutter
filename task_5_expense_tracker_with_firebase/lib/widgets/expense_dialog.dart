import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../const.dart';
import '../models/expense_model.dart';
import '../providers/expense_provider.dart';
import 'custom_textfield.dart';

class ExpenseDialog extends StatefulWidget {
  final Expense? expense;

  const ExpenseDialog({super.key, this.expense});

  @override
  _ExpenseDialogState createState() => _ExpenseDialogState();
}

class _ExpenseDialogState extends State<ExpenseDialog> {
  late TextEditingController descriptionController;
  late TextEditingController amountController;
  late TextEditingController dateController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    descriptionController =
        TextEditingController(text: widget.expense?.description ?? '');
    amountController = TextEditingController(
        text: widget.expense?.amount.toInt().toString() ?? '');
    dateController = TextEditingController(
        text: widget.expense != null
            ? DateFormat.yMMMd().format(widget.expense!.createdAt)
            : '');
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: AppColors
                  .primaryGreen, // Change primary color to your desired color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      dateController.text = DateFormat.yMMMd().format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // Background color of the dialog
      title: Center(
        child: Text(widget.expense == null ? 'Add Expense' : 'Edit Expense'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'Description',
                  controller: descriptionController,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter a Description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Amount',
                  controller: amountController,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter an Amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => selectDate(context),
                  child: IgnorePointer(
                    child: CustomTextField(
                      hintText: 'Select a Date',
                      controller: dateController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select a Date';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey, // Text color of Cancel button
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final date = dateController.text.isNotEmpty
                  ? DateFormat.yMMMd().parse(dateController.text)
                  : DateTime.now();
              final description = descriptionController.text;
              final amount = double.tryParse(amountController.text) ?? 0.0;
              final roundedAmount = amount.roundToDouble();
              final expenseProvider =
                  Provider.of<ExpenseServiceProvider>(context, listen: false);
              if (widget.expense == null) {
                await expenseProvider.addExpense(
                    description, roundedAmount, date);
              } else {
                await expenseProvider.updateExpense(
                    widget.expense!.id, description, roundedAmount, date);
              }
              Navigator.of(context).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryGreen,
          ),
          child: Text(
            widget.expense == null ? 'Add' : 'Update',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
