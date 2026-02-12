import 'package:expense_trackker/views/borrow_screen.dart';
import 'package:expense_trackker/views/lend_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/balance_viewmodel.dart';
import '../income/income_screen.dart';
import '../expense/expense_screen.dart';

import '../widget/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BalanceViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Column(
        children: [
          // ================= TOP SECTION (UNCHANGED UI) =================
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
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Current Balance",
                  style: TextStyle(color: Colors.white70, fontSize: 18),
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

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const IncomeScreen(),
                            ),
                          );
                        },
                        child: ActionButton(
                          icon: Icons.arrow_downward,
                          text: "Income",
                          color: Colors.greenAccent,
                        ),
                      ),
                  
                      const SizedBox(width: 12),
                  
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ExpenseScreen(),
                            ),
                          );
                        },
                        child: ActionButton(
                          icon: Icons.arrow_upward,
                          text: "Expense",
                          color: Colors.redAccent,
                        ),
                      ),
                  
                      const SizedBox(width: 12),
                  
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LendScreen()),
                          );
                        },
                        child: ActionButton(
                          icon: Icons.call_made,
                          text: "Lend",
                          color: Colors.orangeAccent,
                        ),
                      ),
                  
                      const SizedBox(width: 12),
                  
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => BorrowScreen()),
                          );
                        },
                        child: ActionButton(
                          icon: Icons.call_received,
                          text: "Borrow",
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ================= LIST =================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: vm.notes.isEmpty
                  ? const Center(
                      child: Text(
                        "No transactions yet",
                        style: TextStyle(color: Colors.grey),
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
                              // ICON
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
                                  note.isIncome ? Icons.add : Icons.remove,
                                  color: note.isIncome
                                      ? Colors.green
                                      : Colors.red,
                                  size: 20,
                                ),
                              ),

                              const SizedBox(width: 12),

                              // TEXT AREA
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title + Amount
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          note.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Rs. ${note.amount}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: note.isIncome
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 4),

                                    // Small description below
                                    if (note.description.isNotEmpty)
                                      Text(
                                        note.description,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                              // EDIT DELETE MENU
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == "edit") {
                                    _showEditDialog(context, vm, index, note);
                                  } else {
                                    vm.deleteNote(index);
                                  }
                                },
                                itemBuilder: (context) => const [
                                  PopupMenuItem(
                                    value: "edit",
                                    child: Text("Edit")
                                  ),
                                  PopupMenuItem(
                                    value: "delete",
                                    child: Text("Delete")
                                  ),
                                ],
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

  // ================= EDIT DIALOG =================
  void _showEditDialog(
    BuildContext context,
    BalanceViewModel vm,
    int index,
    note,
  ) {
    final amountController = TextEditingController(
      text: note.amount.toString(),
    );
    final descController = TextEditingController(text: note.description);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Transaction"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount"),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newAmount = double.tryParse(amountController.text);
              if (newAmount != null) {
                vm.editNote(index, newAmount, descController.text);
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
