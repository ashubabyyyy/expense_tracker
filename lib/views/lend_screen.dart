import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/balance_viewmodel.dart';
import '../widget/widgets.dart';

class LendScreen extends StatefulWidget {
  const LendScreen({super.key});

  @override
  State<LendScreen> createState() => _LendScreenState();
}

class _LendScreenState extends State<LendScreen> {
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
              headerWidget(context, "Lend Money"),
              const SizedBox(height: 30),

              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration("Amount"),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: descriptionController,
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration("Person Name / Description"),
              ),

              const Spacer(),

              continueButton(() {
                final amount = double.tryParse(amountController.text);
                final description = descriptionController.text.trim();

                if (amount != null) {
                  context.read<BalanceViewModel>().addLend(
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

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xff3A3A3A),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
