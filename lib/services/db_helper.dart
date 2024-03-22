import 'dart:convert';

import 'package:assesment/models/entryModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

 static Future<Database> initDatabase() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = join(directory.path, 'new3.db');
  print('Database path: $path'); 
  final database = await openDatabase(path, version: 1, onCreate: _createDatabase);
  _createDatabase(database, 1);
  print("init database"); 
  return database;
}


static void _createDatabase(Database db, int version) async {
  await db.execute('''
    CREATE TABLE IF NOT EXISTS entries (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      api TEXT,
      description TEXT,
      auth TEXT,  
      cors TEXT,
      link TEXT,
      category TEXT
    )
  ''');
}


  static Future<int> insertEntry(Map<String, dynamic> entry) async {
    final db = await database;
     return await db.insert('entries', entry);

  }

 
 static Future<List<EntryModel>> getAllEntries() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query('entries');
    return results.map((e) => EntryModel(
      api: e['api'], 
      category: e['category'],
    description: e['description'],
    auth: e['auth'], 
    cors: e['cors'], 
    link: e['link'],
    )).toList();
  }

static Future<Map<String, dynamic>?> getEntryById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'entries',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null; 
    }
  }
  
  static Future<int> deleteEntry(String api) async {
  final db = await database;
  return await db.delete('entries', where: 'api = ?', whereArgs: [api]);
}

  
  static Future<int> updateEntry( String api, category, String description,String auth,String cors,String link  ) async {
  final db = await database;
  return await db.update('entries', {
    'category': category,
   'description': description,
   'auth': auth,
    'cors': cors,
    'link': link,

  }, where: 'api = ?', whereArgs: [api]);
}

}
