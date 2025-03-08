import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/getx_controller/task_controller.dart';
import '../models/task_models.dart';
import 'package:taskapp/screens/update_task.dart';

import 'task_add_screen.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
          title: Text("Task Manager")),
      body: Obx(() {
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return ListTile(
              leading:   IconButton(
                icon: Icon(Icons.edit, color: Colors.orange),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Update Task"),
                      content: UpdateTaskDialog(task: task),
                    ),
                  );
                },
              ),
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => taskController.deleteTask(task.id,task.title,task.description),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

          Get.to(() => TaskAddScreen());},
      ),
    );
  }
}
