import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:taskapp/main.dart';
import '../fcm_services/notifications_services.dart';
import '../models/task_models.dart';

class TaskController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }


  void fetchTasks() {
    firestore.collection('tasks').snapshots().listen((snapshot) {
      tasks.value = snapshot.docs.map((doc) {
        return Task.fromJson({...doc.data(), 'id': doc.id}); // Ensure ID is mapped
      }).toList();
    });
  }



  Future<void> addTask(String title, String description) async {
    try {
      DocumentReference docRef = firestore.collection('tasks').doc();

      Task newTask = Task(
        id: docRef.id,
        title: title,
        description: description,
        // createdAt: DateTime.now(),
      );

      await docRef.set(newTask.toJson());
      NotificationService.showLocalNotification(
        "New Task Added",
        "$title: $description",
      );

      // sendPushMessage("New Task Created", "$title: $description");
      print("Adding Task: $title");
    } catch (e) {
      print("Error adding task: $e"); // Debugging
    }
  }



  Future<void> updateTask(String id, String title, String description) async {
    await firestore.collection('tasks').doc(id).update({
      'title': title,
      'description': description,
    });


    int index = tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      tasks[index] = Task(id: id, title: title, description: description);
      tasks.refresh();
    }
    NotificationService.showLocalNotification(
      "Your Task updated",
      "$title: $description",

    );
   // sendPushMessage("Task Updated", "$title: $description");
  }

  Future<void> deleteTask(String id,String title, String description) async {
    await firestore.collection('tasks').doc(id).delete();
    NotificationService.showLocalNotification(
        "Your task has been deleted",
      "$title: $description",

    );
  }
}


//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:googleapis/batch/v1.dart';
// import 'package:taskapp/main.dart';
//
// class TaskController extends GetxController {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   var tasks = <Task>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchTasks();
//   }
//
//   void fetchTasks() {
//     firestore.collection('tasks').snapshots().listen((snapshot) {
//       tasks.value = snapshot.docs.map((doc) {
//         return Task.fromJson({...doc.data(), 'id': doc.id});
//       }).toList();
//     });
//   }
//
//   Future<void> addTask(String title, String description) async {
//     try {
//       DocumentReference docRef = firestore.collection('tasks').doc();
//
//       Task newTask = Task(
//         id: docRef.id,
//         title: title,
//         description: description,
//       );
//
//       await docRef.set(newTask.toJson());
//
//       // 🔔 Show local notification
//       NotificationService.showLocalNotification(
//         "New Task Added",
//         "$title: $description",
//       );
//     } catch (e) {
//       print("Error adding task: $e");
//     }
//   }
//
//   Future<void> updateTask(String id, String title, String description) async {
//     await firestore.collection('tasks').doc(id).update({
//       'title': title,
//       'description': description,
//     });
//
//     int index = tasks.indexWhere((task) => task.id == id);
//     if (index != -1) {
//       tasks[index] = Task(id: id, title: title, description: description);
//       tasks.refresh();
//     }
//
//     // 🔔 Show local notification
//     NotificationService.showLocalNotification(
//       "Task Updated",
//       "$title: $description",
//     );
//   }
//
//   Future<void> deleteTask(String id) async {
//     await firestore.collection('tasks').doc(id).delete();
//
//     // 🔔 Show local notification
//     NotificationService.showLocalNotification(
//       "Task Deleted",
//       "A task was removed.",
//     );
//   }
// }
