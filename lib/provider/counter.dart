import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:music_app/provider/userdata.dart';


class Counter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return context.watch<UserData>().secretcode;
  }
}