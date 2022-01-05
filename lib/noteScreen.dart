import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app_firebase/addnote.dart';
import 'package:notes_app_firebase/editNote.dart';
class NoteScreen extends StatefulWidget {
  String userUID;
  NoteScreen({required this.userUID});
  @override
  _NoteScreenState createState() => _NoteScreenState(userUID: userUID);
}

class _NoteScreenState extends State<NoteScreen> {
  String userUID;
  _NoteScreenState({required this.userUID});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes App'),),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('notes').doc(userUID).collection('user_notes').orderBy('timestamp').snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData == true) {
            List<Map<String, dynamic>> docs = [];
            snapshot.data!.docs.forEach((element) {docs.add(element.data() as Map<String, dynamic>);});
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.yellow,
                          child: Text(docs[index]['subject']),
                        ),
                        Container(
                          color: Colors.grey,
                          child: Text(docs[index]['note']),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditNote(enteredSubject:docs[index]['subject'],enteredNote:docs[index]['note'],docId: snapshot.data!.docs[index].id,userUID: userUID,)));
                              },
                              child: Text('Edit'),
                            ),
                            ElevatedButton(
                              onPressed: (){
                                FirebaseFirestore.instance.collection('notes').doc(userUID).collection('user_notes').doc(snapshot.data!.docs[index].id).delete();
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      ],
                    )
                );
              },
            );
          } else {
            return Center(child: Text('Loading...'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('ADD'),
        onPressed: () {
          Navigator
              .push(context, MaterialPageRoute(builder: (context) {
            return AddScreen(userUID: userUID);
          }));
        },
      ),
    );
  }
}
