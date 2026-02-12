import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

Future<void> exportCSVFile(String csvData) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/transaction_history.csv');
  await file.writeAsString(csvData);
}
