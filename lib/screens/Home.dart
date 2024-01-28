import 'package:flutter/material.dart';
import 'package:todo/auth/authscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/screens/add_task.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

void _signOut() async {
  try {
    await _auth.signOut();
    print('User signed out');
  } catch (e) {
    print('Error signing out: $e');
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('TODO')),
        backgroundColor: Colors.green[300],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:  ElevatedButton(
          onPressed: _signOut,
          child: Text('Sign Out')
          ,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Theme.of(context).primaryColor, onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddTask()));
      }),
    );
  }
}
