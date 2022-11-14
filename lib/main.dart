import 'package:flutter/material.dart';
import 'package:music_app/pages/authenticate.dart';
import 'package:music_app/pages/login.dart';
import 'package:music_app/pages/songlist.dart';
import 'package:music_app/pages/viewprofile.dart';
import 'package:music_app/provider/userdata.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> UserData())
  ],
     child: MyApp(),));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home : Authenticate());
  }
}
