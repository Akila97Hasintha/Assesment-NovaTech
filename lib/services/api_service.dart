import 'package:assesment/models/entryModel.dart';
import 'package:assesment/services/db_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchDataAndSaveToDB() async {
  try {
  final response = await http.get(Uri.parse('https://api.publicapis.org/entries'));
  print(response.body);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    List<dynamic> entriesData = data['entries'];


    for (var entryData in entriesData) {
      EntryModel entryModel = EntryModel.fromJson(entryData);
      await DatabaseHelper.insertEntry(entryModel.toJson());
      print('Entry inserted successfully:');
    }
  } else {
    throw Exception('Failed to fetch data from API');
  }
   } catch (e) {
    print('Error Save: $e');
    
  }
}
