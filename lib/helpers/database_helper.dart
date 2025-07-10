// import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:path_provider/path_provider.dart';
import '../models/todo.dart';
import 'sembast_db_factory.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static const String _dbName = 'todo.db';
  static const String _storeName = 'todos';

  static Database? _database;
  final _store = intMapStoreFactory.store(_storeName);

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(_dbName);
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    String dbPath;

    if (kIsWeb) {
      dbPath = fileName;
    } else {
      final dir = await getApplicationDocumentsDirectory();
      dbPath = join(dir.path, fileName);
    }

    return await databaseFactory.openDatabase(dbPath);
  }

  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    final key = await _store.add(db, todo.toMap());
    return key;
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final records = await _store.find(db);
    return records.map((snapshot) {
      final todo = Todo.fromMap(snapshot.value);
      return todo.copyWith(id: snapshot.key);
    }).toList();
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    final finder = Finder(filter: Filter.byKey(todo.id));
    return await _store.update(db, todo.toMap(), finder: finder);
  }

  Future<int> deleteTodo(int id) async {
    final db = await database;
    final finder = Finder(filter: Filter.byKey(id));
    return await _store.delete(db, finder: finder);
  }
}
