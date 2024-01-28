import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/auth/authscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/screens/add_task.dart';
import 'package:todo/screens/description.dart';

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
  String uid = '';

  @override
  void initState() {
    getUid();
    // TODO: implement initState
    super.initState();
  }

  void getUid() {
    final User? user = _auth.currentUser;
    setState(() {
      uid = user?.uid ?? '';
    });

    if (uid.isEmpty) {
      // Handle the case where uid is empty, for example, by showing an error message.
      print('Error: User UID is empty.');
      // You may want to handle this error case appropriately for your application.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('TODO')),
        backgroundColor: Colors.green[300],
      ),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('tasks')
              .doc(uid)
              .collection('mytasks')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final docs = snapshot.data?.docs ?? [];

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  var time = (docs[index]['timestamp'] as Timestamp)
                      .toDate();
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Description(title: docs[index]['title'], description: docs[index]['description'])));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff121211),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    docs[index]['title'],
                                    style: GoogleFonts.roboto(fontSize: 20),
                                  )),
                              SizedBox(height: 5,),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(DateFormat.yMd().add_jm().format(time)),
                              )
                            ],
                          ),
                          Container(
                            child: IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('tasks')
                                      .doc(uid)
                                      .collection('mytasks')
                                      .doc(docs[index]['time'])
                                      .delete();
                                },
                                icon: Icon(
                                  Icons.delete,
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddTask()));
          }),
    );
  }
}
