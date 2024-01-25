import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _username = '';
  bool isLoginPage = false;




  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isLoginPage)
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Incorrect username';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value ?? '';
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: new BorderSide(),
                                borderRadius: new BorderRadius.circular(8.0)),
                            labelText: "Enter username ",
                            labelStyle: GoogleFonts.roboto()),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value?.isEmpty ??
                            true || !(value?.contains('@') ?? false)) {
                          return 'Incorrect Email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value ?? '';
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(),
                              borderRadius: new BorderRadius.circular(8.0)),
                          labelText: "Enter Email ",
                          labelStyle: GoogleFonts.roboto()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Incorrect password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value ?? '';
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(),
                              borderRadius: new BorderRadius.circular(8.0)),
                          labelText: "Enter Password ",
                          labelStyle: GoogleFonts.roboto()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        height: 70,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor),
                            onPressed: () {},
                            child: isLoginPage
                                ? Text(
                                    "Login",
                                    style: GoogleFonts.roboto(fontSize: 16),
                                  )
                                : Text("SignUp",
                                    style: GoogleFonts.roboto(fontSize: 16)))),
                    SizedBox(
                      height: 10,
                    ),
                    Container(child: TextButton(onPressed: (){
                      setState(() {
                        isLoginPage = !isLoginPage;
                      });
                    }, child: isLoginPage? Text("Not a member "): Text("Already a member ?")),)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
