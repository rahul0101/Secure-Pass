import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Home.dart';

class ChangePassword extends StatelessWidget {
  final String websiteName;
  final String userPhone;
  final databaseReference = Firestore.instance;

  ChangePassword(this.websiteName, this.userPhone);
// Within the SecondRoute widget

  _getUserId() {
    databaseReference
        .collection("passwords")
        .document(userPhone)
        .updateData({websiteName: passwordController.text});
  }

  final websiteNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text('UpdateWebsite'),
          textTheme: TextTheme(
            title: TextStyle(color: Colors.greenAccent, fontSize: 20),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[

                    Card(
                      elevation: 5,
                      child: TextField(
                        decoration: InputDecoration(labelText: ' password'),
                        //onChanged: (val){Password=val;},
                        controller: passwordController,
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: TextField(
                        decoration:
                        InputDecoration(labelText: ' ConfirmPassword'),
                        //  onChanged:(val){ConfirmPassword=val;},
                        controller: confirmPasswordsController,
                      ),
                    )
                  ],
                )),
            RaisedButton(
              child: Text('update'),
              // Within the SecondRoute widget
              onPressed: () {

                _getUserId();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Passwords();
                  }),
                );
              },
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Colors.black87,
                ),
              ),
              textColor: Colors.greenAccent,
            )
          ],
        ),
      ),
    );
  }
}
