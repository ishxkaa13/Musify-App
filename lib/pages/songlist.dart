
import 'package:flutter/material.dart';

class Songlist extends StatefulWidget {
  const Songlist({Key? key}) : super(key: key);

  @override
  State<Songlist> createState() => _SonglistState();
}

class _SonglistState extends State<Songlist> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
  ];
  var value;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Scaffold(
    backgroundColor: Colors.grey[850],
    appBar: AppBar(
      title: const Text("Vibe"),
      centerTitle: true,
      backgroundColor: Colors.grey[900],
      actions: [
        IconButton(onPressed: (){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: const Text("Add Song"),
              content: TextFormField(onChanged: (v){
               value = v;
              },),
              actionsOverflowButtonSpacing: 20.0,
              actions: [
                ElevatedButton(onPressed: (){
                  items.add(value);
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
    body: SizedBox(
      height: 1000.0,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.grey[850],
          child: ListTile(
            leading: const Icon(Icons.circle_outlined),
            title: Text(items[index]),
            trailing: IconButton(onPressed: (){
              items.removeAt(index);
              setState((){});
            },
              icon: const Icon(Icons.adb),),
          ),
        );

      }),
    ),
  ) ;
  }
}