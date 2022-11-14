import 'package:flutter/material.dart';
import 'package:music_app/pages/viewprofile.dart';
import 'package:music_app/provider/userdata.dart';
import 'package:music_app/services/register.dart';
import 'package:provider/provider.dart';
import '../provider/userdata.dart';

class Login extends StatefulWidget {
  //const Login({Key? key}) : super(key: key);
  final Function toggleView;
  const Login({required this.toggleView});


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  late var Secretkey;
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserData>(context);
    return Scaffold(
      backgroundColor: Colors.grey[850],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          title: const Text("Vibe"),
          actions: [
            IconButton(onPressed: (){
              widget.toggleView();
            }, icon: const Icon(Icons.person)),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
                key: _formkey,
                child: Column(

                  children: [
                    const SizedBox(height: 180.0),
                    TextFormField(onChanged: (v){
                      Secretkey = v;
                    },

                        decoration: const InputDecoration(hintText: "SecretCode",
                            hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.blueGrey)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 4.0,color: Colors.blueGrey))
                    )),
                     SizedBox(height: 20.0),
                    OutlinedButton(onPressed: ()async{

                      var a =await loginUser(Secretkey);
                      // UserData(secretcode: Secretkey);
                      data.secretcode = Secretkey;
                      // var b = context.read<UserData>().sc;

                      if(a!=null){
                        UserData(secretcode:Secretkey);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Viewprofile()),
                        );
                      }


                    },
                        child:const Text("Login",style: TextStyle(
                            fontStyle: FontStyle.italic
                        ),)
                    ),


                  ],
                )),
          ),
        )

    );
  }
}


