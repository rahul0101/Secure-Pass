import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steel_crypt/steel_crypt.dart';
import './ViewWebSite.dart';
import './AddWebsite.dart';

class Passwords extends StatefulWidget {
  Passwords({Key key, this.userPhone}) : super(key: key);
  final String userPhone;

  @override
  State<StatefulWidget> createState() {return PasswordsState();}
}

class PasswordsState extends State<Passwords> {

  void _refresh() async {
    setState(() {});
  }

  final databaseReference = Firestore.instance;

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text('Home'),
          textTheme: TextTheme(
            title: TextStyle(color: Colors.greenAccent, fontSize: 20),
          ),
        ),
        body: new StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('passwords')
                .document(widget.userPhone)
                .snapshots(includeMetadataChanges: false),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                print("no data");
                return new Center(
              child:CircularProgressIndicator(
                backgroundColor: Colors.blue,
              )
                );
              }
              return new ListView(
                children: (snapshot.data.data.keys).map((answer) {
                  return Container(
                      width: double.infinity,
                      height: 60,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                          color: Colors.black87,
                          elevation: 5,
                          child: ListTile(
                            onTap: () async {
                              final prefs = await SharedPreferences.getInstance();
                              String key = prefs.getString('key');
                              String iv = prefs.getString('iv');
                              var decrypter = AesCrypt(key, 'cbc', 'iso10126-2');
                              String passw = decrypter.decrypt(snapshot.data.data[answer], iv);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return ViewWebSite(answer, passw, widget.userPhone);
                                }),
                              ).then((val) => val ? _refresh() : null);
                            },
                            title: Text(answer,
                                style: TextStyle(color: Colors.greenAccent),
                                textAlign: TextAlign.center,
                                textScaleFactor: (2)),
                          )));
                }).toList(),
              );
            }),
        floatingActionButton: FloatingActionButton(
          // Within the `FirstRoute` widget
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return AddWebsite(widget.userPhone);
              }),
            ).then((val) => val ? _refresh() : null);
          },

          tooltip: 'Increment',
          child: Icon(
            Icons.add,
            size: 35.5,
          ),
        ),
      ),
    );
  }
}
