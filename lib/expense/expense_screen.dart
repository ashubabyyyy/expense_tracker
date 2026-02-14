import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/balance_viewmodel.dart';
import '../widget/widgets.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2A2A2A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 30),
              headerWidget(context, "Add Expense"),
              const SizedBox(height: 30),

              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff3A3A3A),
                  hintText: "Amount",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff3A3A3A),
                  hintText: "Description (optional)",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
              ),
              const Spacer(),

              continueButton(() {
                final amount = double.tryParse(amountController.text);
                final description = descriptionController.text.trim();

                if (amount != null) {
                  context.read<BalanceViewModel>().addExpense(
                    amount,
                    description: description,
                  );
                  Navigator.pop(context);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}