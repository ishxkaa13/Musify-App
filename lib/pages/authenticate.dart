import 'package:flutter/material.dart';
import 'package:music_app/pages/login.dart';
import 'package:music_app/pages/signup.dart';
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView(){
    setState(() => showSignIn = !showSignIn);}
  @override
  Widget build(BuildContext context) {
    if (showSignIn != true) {
      return Login(toggleView: toggleView);
    } else {
      return Signup(toggleView: toggleView);
    }
  }}
