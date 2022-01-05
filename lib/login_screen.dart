import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/noteScreen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String enteredEmail="";
  String enteredPassword="";
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: screenWidth*0.8,
            child: TextFormField(
              onChanged: (value){
                enteredEmail=value;
              },
            ),
          ),
          Container(
            width: screenWidth*0.8,
            child: TextFormField(
              onChanged: (value){
                enteredPassword=value;
              },
            ),
          ),
          ElevatedButton(
              child: Text('Log In'),
              onPressed: () async {
                try{
                  var userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: enteredEmail, password: enteredPassword);
                  if(userCred!=null){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteScreen(userUID : userCred.user!.uid)));
                  }
                }
                on FirebaseAuthException catch (error){
                  print(error);
                }
            },
          ),
        ],
      ),
    );
  }
}
