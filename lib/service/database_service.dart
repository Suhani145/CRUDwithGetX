import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo.dart';

class DBService{
  Database? _databaseService;
  final DatabaseName = "todo_list.db";
  final DatabaseVersion = 1;
  final TableName = "todo_table";

  //DB initialization and check if DB is null
Future<Database> get database async{
  if(_databaseService != null){
    return _databaseService!;
  }
  //get DB path
  final DatabasePath = await getDatabasesPath();
  final path = "$DatabasePath/$DatabaseName";

  //open DB
  return await openDatabase(path,
  version: DatabaseVersion,
    onCreate: (db, version)async{
    await db.execute('''
    CREATE TABLE $TableName(
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     title TEXT NOT NULL,
     description TEXT NOT NULL
    )
    ''');
    }
  );
  }

  //insert data
  Future<void> insertTodo(Todo todoModel) async{
    final db = await database;
    print('Insert the todo');
    await db.insert(TableName, todoModel.toMap());
  }

  //delete data
  Future<void> deleteTodo(int id) async {
    final db = await database;
    print('delete the todo');
    await db.delete(TableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

    //update data
    Future<void> updateTodo(int id, Todo todoModel) async {
      final db = await database;
      print("update the todo");
      await db.update(TableName,
        todoModel.toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
    }
      //fetch all data
      Future<List<Todo>> fetchAllTodo() async{
        final db = await database;
        final List<Map<String, dynamic>> maps = await db.query(TableName);
        print("Fetch all the todos");
        return List.generate(maps.length, (i) {
          return Todo.fromMap(maps[i]);
        }
        );
      }



  //close DB
  Future<void> closeDatabase() async{
    final db = await database;
    print("cosing db");
    return db.close();
  }

}
