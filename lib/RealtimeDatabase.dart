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

  // very useful see carefully. All time realtime data show korbe
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Padding(padding: EdgeInsets.all(12),
              child: Text(countvalue.toString()+ " database - "+databaseJson),
              ),
SizedBox(height: 30,),
              TextButton(onPressed: (){
              _createDB();
              }, child: Text('Create DB')),
              TextButton(onPressed: (){
                _realdb_once();
              }, child: Text('Read value')),
              TextButton(onPressed: (){
              _readdb_onechild();
              }, child: Text('Read Once Child')),
              TextButton(onPressed: (){
            _updateValue();
              }, child: Text('Update Value')),
              TextButton(onPressed: (){
_updatevalue_count();
              }, child: Text('Update Counter value by 1')),
              TextButton(onPressed: (){
              _delete();
              }, child: Text('Delete Value'))
            ],
          ),
        ),
      )),

    );
  }
  // create database function
  _createDB(){
    // 2 ta row(document) create hobe profile and jobprofile
    _dbref.child('profile').set("Jakaria Profile");
    _dbref.child('jobprofile').set({  // add data in json format(map<String, dynamic>)
      "website1": "www.jakaria.com",
      "website2": "www.khan.com"
    });
  }

  _realdb_once(){
    _dbref.child('jobprofile').child('website2').once().then((snapshotData){
      print('read once - '+ snapshotData.snapshot.value.toString());
      setState(() {
        databaseJson = snapshotData.snapshot.value.toString();
      });
    });
  }

  _readdb_onechild(){
    _dbref.child("jobprofile").child("website2").once().then((dataSnapshot){
      print(" read once - "+ dataSnapshot.snapshot.value.toString() );
      setState(() {
        databaseJson = dataSnapshot.snapshot.value.toString();
      });
    });
  }

  _updateValue(){
    _dbref.child('jobprofile').update({
      "website2": "www.updatewebsite.com"
    });
  }
// this is useful
  _updatevalue_count(){
    _dbref.child('myCountKey').update({
      "key_counter": countvalue+1
    });
  }
// profile(document) delete
  _delete(){
    _dbref.child('profile').remove();
  }
}
