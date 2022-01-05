import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app_firebase/addnote.dart';
import 'package:notes_app_firebase/editNote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp(),));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('notes')
              .orderBy('timestamp')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData == true) {
              List<Map<String, dynamic>> docs = [];
              snapshot.data!.docs.forEach((element) {docs.add(element.data() as Map<String, dynamic>);});
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Text(docs[index]['subject']),
                    trailing: Text(docs[index]['note']),
                    subtitle: Row(
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditNote(enteredSubject:docs[index]['subject'],enteredNote:docs[index]['note'],docId: snapshot.data!.docs[index].id)));
                          },
                          child: Text('Edit'),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            // print(snapshot.data!.docs[index].id);
                            FirebaseFirestore.instance.collection('notes').doc(snapshot.data!.docs[index].id).delete();
                            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeleteNote(enteredSubject:docs[index]['subject'],enteredNote:docs[index]['note'],docId: snapshot.data!.docs[index].id)));
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    ),
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
              return AddScreen();
            }));
          },
        ),
    );
  }
}
