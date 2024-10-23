import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Realtimedatabase extends StatefulWidget {
  const Realtimedatabase({super.key});

  @override
  State<Realtimedatabase> createState() => _RealtimedatabaseState();
}

class _RealtimedatabaseState extends State<Realtimedatabase> {
  late DatabaseReference _dbref;
  String databaseJson = "";
  int countvalue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // when app open automatically get data from database
    connectRealTimeDatabase();
  }
  void connectRealTimeDatabase(){
  _dbref = FirebaseDatabase.instance.ref();  // at first get instance

    _dbref.child('myCountKey').child('key_counter').onValue.listen((event){
      print('Counter update: '+ event.snapshot.value.toString());
      setState(() {
        // countvalue int tai String ke int a convert korsi
        countvalue = int.parse(event.snapshot.value.toString());
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(8),
            child: Text(countvalue.toString()+ " database - "+databaseJson),
            ),

            TextButton(onPressed: (){

            }, child: Text('Create DB')),
            TextButton(onPressed: (){

            }, child: Text('Read value')),
            TextButton(onPressed: (){

            }, child: Text('Read Once Child')),
            TextButton(onPressed: (){

            }, child: Text('Update Value')),
            TextButton(onPressed: (){

            }, child: Text('Update Counter value by 1')),
            TextButton(onPressed: (){

            }, child: Text('Delete Value'))
          ],
        ),
      )),

    );
  }
  _createDB(){
    // 2 ta row(document) create hobe profile and jobprofile
    _dbref.child('profile').set("Jakaria Profile");
    _dbref.child('jobprofile').set({  // add data in json format(map<String, dynamic>)
      "website1": "www.jakaria.com",
      "website2": "www.khan.com"
    });
  }
}
