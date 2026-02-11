import 'package:expense_trackker/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/balance_viewmodel.dart';
import '../income/income_screen.dart';
import '../expense/expense_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BalanceViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Column(
        children: [
          
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff1B1B1B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Current Balance",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Rs. ${vm.balance.toStringAsFixed(0)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

              
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const IncomeScreen()),
                        );
                      },
                      child: ActionButton(
                        icon: Icons.arrow_downward,
                        text: "Income",
                        color: Colors.greenAccent,
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ExpenseScreen()),
                        );
                      },
                      child: ActionButton(
                        icon: Icons.arrow_upward,
                        text: "Expense",
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

        
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: vm.notes.isEmpty
                  ? const Center(
                      child: Text(
                        "No transactions yet",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: vm.notes.length,
                      itemBuilder: (context, index) {
                        final note = vm.notes[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: note.isIncome
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                ),
                                child: Icon(
                                  note.isIncome
                                      ? Icons.add
                                      : Icons.remove,
                                  color: note.isIncome
                                      ? Colors.green
                                      : Colors.red,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  note.text,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
