import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/notes_model.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class BalanceViewModel extends ChangeNotifier {
  double _balance = 0;
  final List<NoteModel> _notes = [];

  double get balance => _balance;
  List<NoteModel> get notes => List.unmodifiable(_notes);

  BalanceViewModel() {
    restoreData();
  }

  Future<void> _autoBackup() async {
    final prefs = await SharedPreferences.getInstance();

    final List<Map<String, dynamic>> notesMap = _notes
        .map((n) => n.toMap())
        .toList();

    final data = {'balance': _balance, 'notes': notesMap};

    await prefs.setString('backup', jsonEncode(data));
  }

  Future<void> restoreData() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString('backup');

    if (dataString != null) {
      final data = jsonDecode(dataString);

      _balance = (data['balance'] as num).toDouble();

      _notes.clear();
      _notes.addAll(
        (data['notes'] as List)
            .map((n) => NoteModel.fromMap(Map<String, dynamic>.from(n)))
            .toList(),
      );

      notifyListeners();
    }
  }

  void addIncome(double amount, {String description = ""}) {
    _balance += amount;

    _notes.insert(
      0,
      NoteModel(
        title: "Income",
        description: description,
        amount: amount,
        isIncome: true,
      ),
    );

    _autoBackup();
    notifyListeners();
  }

  void addExpense(double amount, {String description = ""}) {
    _balance -= amount;

    _notes.insert(
      0,
      NoteModel(
        title: "Expense",
        description: description,
        amount: amount,
        isIncome: false,
      ),
    );

    _autoBackup();
    notifyListeners();
  }

  void addLend(double amount, {String description = ""}) {
    _balance -= amount;

    _notes.insert(
      0,
      NoteModel(
        title: "Lend",
        description: description,
        amount: amount,
        isIncome: false,
      ),
    );

    _autoBackup(); // 🔥 AUTO SAVE
    notifyListeners();
  }

  void addBorrow(double amount, {String description = ""}) {
    _balance += amount;

    _notes.insert(
      0,
      NoteModel(
        title: "Borrow",
        description: description,
        amount: amount,
        isIncome: true,
      ),
    );

    _autoBackup(); // 🔥 AUTO SAVE
    notifyListeners();
  }

  void deleteNote(int index) {
    final note = _notes[index];

    if (note.isIncome) {
      _balance -= note.amount;
    } else {
      _balance += note.amount;
    }

    _notes.removeAt(index);

    _autoBackup(); // 🔥 AUTO SAVE
    notifyListeners();
  }

  void editNote(int index, double newAmount, String newDescription) {
    final oldNote = _notes[index];

    if (oldNote.isIncome) {
      _balance -= oldNote.amount;
    } else {
      _balance += oldNote.amount;
    }

    if (oldNote.isIncome) {
      _balance += newAmount;
    } else {
      _balance -= newAmount;
    }

    _notes[index] = NoteModel(
      title: oldNote.title,
      description: newDescription,
      amount: newAmount,
      isIncome: oldNote.isIncome,
    );

    _autoBackup(); // 🔥 AUTO SAVE
    notifyListeners();
  }

  String exportCSV() {
    final List<List<dynamic>> rows = [
      ["Title", "Description", "Amount", "Type"],
    ];

    for (var note in _notes) {
      rows.add([
        note.title,
        note.description,
        note.amount,
        note.isIncome ? "Income" : "Expense",
      ]);
    }

    return const ListToCsvConverter().convert(rows);
  }

  Future<void> exportCSVFile() async {
    final csvData = exportCSV();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/transaction_history.csv');
    await file.writeAsString(csvData);
  }

  Future<void> exportPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          children: [
            pw.Text("Transaction History", style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: ["Title", "Description", "Amount", "Type"],
              data: _notes
                  .map(
                    (n) => [
                      n.title,
                      n.description,
                      n.amount.toString(),
                      n.isIncome ? "Income" : "Expense",
                    ],
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/transaction_history.pdf');
    await file.writeAsBytes(await pdf.save());
  }
}
