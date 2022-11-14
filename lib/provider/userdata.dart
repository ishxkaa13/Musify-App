import 'package:flutter/material.dart';
import 'package:music_app/services/register.dart';

class UserData with ChangeNotifier{

  var secretcode;
  UserData({this.secretcode});

  @override
   notifyListeners();


}