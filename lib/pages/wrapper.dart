import 'package:flutter/material.dart';
import 'package:music_app/pages/authenticate.dart';
import 'package:music_app/pages/viewprofile.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var user;
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Authenticate();
    }else{
      return const Viewprofile();
    }
  }
}