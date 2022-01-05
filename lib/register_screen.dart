import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app_firebase/noteScreen.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                var userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: enteredEmail, password: enteredPassword);
                if(userCred!=null){
                    FirebaseFirestore.instance.collection('notes').doc(userCred.user!.uid).collection('user_notes');
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
