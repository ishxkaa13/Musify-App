import 'package:music_app/provider/userdata.dart';
import 'package:music_app/services/register.dart';
import 'package:flutter/material.dart';
import 'package:music_app/pages/viewprofile.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  //const Signup({Key? key}) : super(key: key);

  final Function toggleView;
   const Signup({required this.toggleView});



  @override
  State<Signup> createState() => _SignupState();

}

class _SignupState extends State<Signup> {

  final _formkey = GlobalKey<FormState>();
  String? Username;
  late String email;
  late String name;
  @override
  Widget build(BuildContext context) {
    final data1 = Provider.of<UserData>(context);

    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: const Text("Vibe"),
        actions: [
          IconButton(onPressed: (){
            widget.toggleView();
          }, icon: const Icon(Icons.person_add)),
        ],
      ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formkey,
          child: Column(
            children: [
              TextFormField(onChanged: (v){
                name = v;
              },
                decoration: const InputDecoration(hintText: "Name" ,
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.blueGrey)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 4.0,color: Colors.blueGrey))),),
              const SizedBox(height: 16.0),
              TextFormField(
                onChanged:(v){
                  email=v;
                },

                  decoration: const InputDecoration(hintText: "Email",
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.blueGrey)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 4.0,color: Colors.blueGrey))),),
              const SizedBox(height: 15.0),
              OutlinedButton(onPressed: ()async{

                User data = await createUser(name, email);
                Username = data.name;
                data1.secretcode = data.secretCode;
                print(Username);

                if(data.name!=null){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  Viewprofile()),
                );}
              },
                  child:const Text("SignUp",style: TextStyle(
                    fontStyle: FontStyle.italic
                  ),)
              ),


            ],
          )),
    )

    );
  }
}
