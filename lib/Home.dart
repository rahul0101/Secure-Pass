

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './ViewWebSite.dart';
import './AddWebsite.dart';




class Passwords extends StatefulWidget
{
    List<String> WebsiteNames=[""];



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PasswordsState();
  }
}
class PasswordsState extends State<Passwords>
{
  FirebaseUser User;

  List<String> WebsiteNames=[];

void _Userid() async{
  User =  await FirebaseAuth.instance.currentUser();

}

  void  _deletePassword() async
  {
    setState(() {

    });

  }

  final databaseReference = Firestore.instance;


void initState()
{
_Userid();

}




  Widget build (BuildContext context)

  {




    return MaterialApp(home: Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87,title:Text('Home'),
        textTheme: TextTheme(title: TextStyle(color: Colors.greenAccent,fontSize:20),
        ),),

      body:new StreamBuilder<DocumentSnapshot>(
       stream: Firestore.instance.collection('passwords').document('+919740167142').snapshots(includeMetadataChanges: false),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          print("no data");
          return new Text('Loading...');
        }
        print(snapshot.data.data['sandeep']);
        return new ListView(children:

        (snapshot.data.data.keys).map((answer) {
          return Container(
              width: double.infinity,
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Card(
                  color: Colors.black87,
                  elevation: 5,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ViewWebSite(answer, WebsiteNames,snapshot.data.data[answer]);
                        }),
                      ).then((val) => val ? _deletePassword() : null);
                    },
                    title: Text(answer,
                        style:
                        TextStyle(color: Colors.greenAccent),
                        textAlign: TextAlign.center, textScaleFactor: (2)),
                  )
              ));
        }
        ).toList()


          ,);
      }
  ),



      floatingActionButton: FloatingActionButton(

        // Within the `FirstRoute` widget
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return AddWebsite(WebsiteNames);
            }),
          ).then((val)=>val?_deletePassword():null);
        },

        tooltip: 'Increment',
        child: Icon(Icons.add,size: 35.5,),),   ),


    );
  }

}


