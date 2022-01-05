import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String enteredSubject = "";
  String enteredNote = "";
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
                FirebaseFirestore.instance.collection('notes').add({"subject" : enteredSubject,"note": enteredNote,"timestamp":DateTime.now().microsecondsSinceEpoch});
                Navigator.pop(context);
              },
            )
          ]
        ),
    );
  }
}
