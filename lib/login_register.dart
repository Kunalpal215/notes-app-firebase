import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app_firebase/login_screen.dart';
import 'package:notes_app_firebase/register_screen.dart';
class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({Key? key}) : super(key: key);

  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: Text('Log In'),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
        ElevatedButton(
          child: Text('Log In'),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
          },
        ),
      ],
    );
  }
}
