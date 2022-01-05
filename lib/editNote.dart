import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class EditNote extends StatefulWidget {
  String enteredNote;
  String enteredSubject;
  String docId;
  String userUID;
  EditNote({required this.enteredNote,required this.enteredSubject,required this.docId,required this.userUID});
  @override
  _EditNoteState createState() => _EditNoteState(enteredNote: enteredNote,enteredSubject: enteredSubject,docId: docId,userUID: userUID);
}

class _EditNoteState extends State<EditNote> {
  String enteredNote;
  String enteredSubject;
  String docId;
  String userUID;
  _EditNoteState({required this.enteredNote,required this.enteredSubject,required this.docId,required this.userUID});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children :[
            Container(
              child: TextFormField(
                initialValue: enteredSubject,
                onChanged: (value){
                  enteredSubject=value;
                },
              ),
            ),
            Container(
              child: TextFormField(
                initialValue: enteredNote,
                onChanged: (value){
                  enteredNote=value;
                },
              ),
            ),
            ElevatedButton(
              child: Text('ADD to notes'),
              onPressed: () async {
                await FirebaseFirestore.instance.collection('notes').doc(userUID).collection('user_notes').doc(docId).update({"subject":enteredSubject,"note":enteredNote});
                Navigator.pop(context);
              },
            )
          ]
      ),
    );
  }
}
