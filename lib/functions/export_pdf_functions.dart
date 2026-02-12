import 'dart:io';
import 'package:expense_trackker/model/notes_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

Future<void> exportPDF(List<NoteModel> notes) async {
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        children: [
          pw.Text("Transaction History", style: pw.TextStyle(fontSize: 20)),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            headers: ["Title", "Description", "Amount", "Type"],
            data: notes
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
