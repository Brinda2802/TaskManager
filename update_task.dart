import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../getx_controller/task_controller.dart';
import '../models/task_models.dart';

class UpdateTaskDialog extends StatefulWidget {
  final Task task;
  UpdateTaskDialog({required this.task});

  @override
  _UpdateTaskDialogState createState() => _UpdateTaskDialogState();
}

class _UpdateTaskDialogState extends State<UpdateTaskDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final TaskController taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: "Title"),
        ),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(labelText: "Description"),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            taskController.updateTask(
              widget.task.id, // Task ID
              titleController.text,
              descriptionController.text,
            );
            Get.back(); // Close the dialog
          },
          child: Text("Update"),
        ),
      ],
    );
  }
}
