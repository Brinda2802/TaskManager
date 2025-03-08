import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/main.dart';

import '../getx_controller/task_controller.dart';

class TaskAddScreen extends StatelessWidget {
  final TaskController taskController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Add Task")
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Title")),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: "Description")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(titleController.text.trim() . isEmpty && descriptionController.text.trim().isEmpty ){
                  NotificationService.showLocalNotification(
                    "Enter any task",
                    "Empty task is not allowed",
                  );
                }else{
                  taskController.addTask(titleController.text, descriptionController.text);
                  Get.back();
                }




              },
              child: Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
