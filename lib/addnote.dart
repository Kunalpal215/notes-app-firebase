import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddScreen extends StatefulWidget {
  String userUID;
  AddScreen({required this.userUID});
  @override
  _AddScreenState createState() => _AddScreenState(userUID: userUID);
}

class _AddScreenState extends State<AddScreen> {
  String enteredSubject = "";
  String enteredNote = "";
  String userUID;
  _AddScreenState({required this.userUID});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children :[
            Container(
              child: TextFormField(
                onChanged: (value){
                  enteredSubject=value;
                },
              ),
            ),
            Container(
              child: TextFormField(
                onChanged: (value){
                  enteredNote=value;
                },
              ),
            ),
            ElevatedButton(
              child: Text('ADD to notes'),
              onPressed: (){
                FirebaseFirestore.instance.collection('notes').doc(userUID).collection('user_notes').add({"subject":enteredSubject,"note":enteredNote,"timestamp":DateTime.now().microsecondsSinceEpoch});
                Navigator.pop(context);
              },
            )
          ]
        ),
    );
  }
}
