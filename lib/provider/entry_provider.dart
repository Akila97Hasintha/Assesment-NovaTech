import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:assesment/models/entryModel.dart';
import 'package:assesment/services/db_helper.dart';

class EntryProvider extends ChangeNotifier {
  List<EntryModel> _entries = [];

  List<EntryModel> get entries => _entries;

  Future<void> fetchEntries() async {
    _entries = await DatabaseHelper.getAllEntries();
    if (kDebugMode) {
      print('Entries length after fetching: ${_entries.length}');
    }
    notifyListeners();
  }

  Future<bool> updateEntry(
    String api,
    String category,
    String description,
    String auth,
    String cors,
    String link,
  ) async {
    int rowsAffected =await DatabaseHelper.updateEntry(
      api,
      category,
      description,
      auth,
      cors,
      link,
    );
     if (rowsAffected > 0) {
    await fetchEntries(); 
    return true; 
  } else {
    return false; 
  }
  }
  
}
