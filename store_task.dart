import 'package:flutter/material.dart';
import 'package:taskapp/screens/update_task.dart';


import 'package:taskapp/models/task_models.dart';



class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;


  TaskCard({required this.task, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min, // Ensure the row takes minimal space
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.orange), // Change to orange for better visibility
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
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );

  }
}
