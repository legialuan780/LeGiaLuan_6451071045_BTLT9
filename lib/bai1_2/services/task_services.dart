import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final CollectionReference tasksCollection =
  FirebaseFirestore.instance.collection('tasks');

  Stream<QuerySnapshot> getTasks() {
    return tasksCollection
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> addTask(String title) async {
    await tasksCollection.add({
      'title': title,
      'isDone': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateTaskStatus(String id, bool isDone) async {
    await tasksCollection.doc(id).update({
      'isDone': isDone,
    });
  }

  Future<void> deleteTask(String id) async {
    await tasksCollection.doc(id).delete();
  }
}