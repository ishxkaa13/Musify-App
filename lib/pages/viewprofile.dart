import 'package:flutter/material.dart';
import 'package:music_app/modal/dropdown.dart';
import 'package:music_app/provider/userdata.dart';
import 'package:music_app/services/register.dart';
import 'package:provider/provider.dart';


class Viewprofile extends StatefulWidget {


  @override
  State<Viewprofile> createState() => _ViewprofileState();
}

class _ViewprofileState extends State<Viewprofile> {
    var name;
   var value;
  var data;
  var a;
  var Username;
  var data1;
  User? register;
   bool isLoading = true;



   List<String> items = [
     'Item1',
     'Item2',
     'Item3',

   ];




   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data1 = Provider.of<UserData>(context, listen: false);
    getViewProfileData();
  }


  Future getViewProfileData() async{
    register = await viewProfile(data1.secretcode);
    //print("/////${register}");
   // print(">>");
    //print(">>> ${register!.name}");
    await Future.delayed(Duration(seconds: 3));
    if(register!=null){
    isLoading = false;
    setState((){});
  }
  else{
    isLoading = true;
    }}

  @override
  Widget build(BuildContext context) {

    var data3 = Provider.of<UserData>(context, listen: false);

    return isLoading ? const CircularProgressIndicator(): Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          title: const Text("Vibe"),
          actions: [
            IconButton(onPressed: (){
              showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(
                  title: const Text("Add Playlist"),
                  content: TextField(onChanged: (v){
                    name = v;
                  },decoration: const InputDecoration(hintText: "Playlist Name"),),
                  actionsOverflowButtonSpacing: 20.0,
                  actions: [
                    ElevatedButton(onPressed: ()async{
                      var secretcode = data3.secretcode;
                      User? data2 = await createPlaylist(secretcode, name );

                      items.add(name);
                      setState((){});
                      Navigator.of(context).pop();
                    },
                        child: const Text("Add"))
                  ],
                );
              });
            }, icon: const Icon(Icons.add))
          ],
        ),
        body: Column(
          children:  [

            const SizedBox(height: 30.0,),

            const Center(
              child: CircleAvatar(
                backgroundColor:Colors.lightBlueAccent ,
              ),
            ),
            const SizedBox(height: 15.0,),

            Text( "${register!.name}",style: const TextStyle(
                fontSize: 35.0,
                color: Colors.white70),),

            const SizedBox(height: 50.0),

            const Text("Recently Added",style: TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic

            ),),

            const SizedBox(height: 15.0),

            SizedBox(
                height: 100,
                child: Dropdown(items : items)),


          ],
        ),
      ),
    );
  }
}
