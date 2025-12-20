import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistwithgetx/controllers/todo_controller.dart';
import '../models/todo.dart';
class TodoFormView extends StatelessWidget {
  final Todo ? todo;
  final TodoController todoController = Get.find();
  TodoFormView({this.todo}){
    if(todo != null){
      todoController.titleController.text = todo!.title;
      todoController.descriptionController.text = todo!.description;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo == null ? "Add Task" : "Edit Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: todoController.titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: todoController.descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height:16),
            ElevatedButton(
                onPressed: () {
                    if(todo == null) {
                      todoController.addTodo();
                    }
                      else{
                       todoController.updateTodo(todo!.id!);
                    }
                    Get.back();
                },
                child: Text(todo == null ? "Add" : "Update"),
            )
          ],
        ),
      ),
    );
  }
}




