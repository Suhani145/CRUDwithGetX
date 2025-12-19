import 'dart:core';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo.dart';

class DBService{
  static final _databaseName = "todo_list.db";
  static final _databaseVersion = 1;
  static final tableName = "todo_table";
  static final columnId= 'id';
  static final columnTitle = 'title';
  static final columnDescription = 'description';
  DBService._privateConstructor();
  static final DBService instance = DBService._privateConstructor();
  Database? _databaseService;

  Future<Database> get database async{
    if(_databaseService != null){
      return _databaseService!;
    }
    _databaseService = await _initDatabase();
    return _databaseService!;
  }

  //initialize the database
  Future<Database>_initDatabase() async{
    String path = join(await getDatabasesPath(),_databaseName);
    return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate
    );
}

//create the sql table
Future<void> _onCreate(Database db, int version) async{
    await db.execute(
      '''CREATE TABLE $tableName(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnTitle TEXT NOT NULL,
      $columnDescription TEXT NOT NULL
      )'''
    );
}

//add new tasks
  Future<int> insert(Todo todo) async{
    Database db = await instance.database;
    var result = await db.insert(tableName, todo.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  //update the tasks
  Future<int> update(int id, Todo todo) async{
    Database db = await instance.database;
    return db.update(tableName,
    {
      'title' : todo.title,
      'description' : todo.description
    },
      where: '$columnId = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  //delete the task
  Future<int> delete(int id) async{
    Database db = await instance.database;
    return await db.delete(tableName,
    where: '$columnId = ?',
      whereArgs: [id]
    );
  }

  //fetch all task data
  Future<List<Map<String, dynamic>>> fetchAllTasks() async{
    Database db = await instance.database;
    var res = await db.query(tableName, orderBy: "$columnId DESC");
    return res;
  }

  Future<List<Map<String, dynamic>>> clearTasks() async{
      Database db = await instance.database;
      return await db.rawQuery("DELETE FROM $tableName");
     }
}


