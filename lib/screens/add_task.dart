import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:todo/screens/Home.dart';

void showCustomToast(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2), // Durée d'affichage du toast
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void addTaskToFirebase() async {
    try {
      // Get the current user
      FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      String uid = user?.uid ?? '';

      // Get the current timestamp
      var time = DateTime.now();

      // Add task to Firestore
      await FirebaseFirestore.instance
          .collection('tasks') // Main collection
          .doc(uid) // User's document
          .collection('mytasks') // Subcollection for tasks
          .doc(time.toString()) // Document ID is set to the current timestamp
          .set({
        'title': titleController.text,
        'description': descriptionController.text,
        'time': time.toString(),
        'timestamp': time,
      });

      // Show a toast message using the toast package
      showCustomToast(context, 'Task Added');
    } catch (e) {
      // Handle errors
      print('Error adding task: $e');
      showCustomToast(context, 'Error adding task');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: 'Enter Title ', border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                    labelText: 'Enter Description  ',
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.blueAccent.shade100;

                      }
                      return Theme.of(context).primaryColor;
                    },
                  ),
                ),
                onPressed: () {
                  addTaskToFirebase();
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>Home()));
                },
                child: Text(
                  'Add Task',
                  style: GoogleFonts.roboto(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
