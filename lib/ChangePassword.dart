import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steel_crypt/steel_crypt.dart';
import './Home.dart';

class ChangePassword extends StatelessWidget {
  final String websiteName;
  final String userPhone;
  final databaseReference = Firestore.instance;

  ChangePassword(this.websiteName, this.userPhone);
// Within the SecondRoute widget

  _updatePassword() async {
    final prefs = await SharedPreferences.getInstance();
    var encrypter = AesCrypt(prefs.getString('key'), 'cbc', 'iso10126-2');
    String encr = encrypter.encrypt(passwordController.text,prefs.getString('iv'));
    databaseReference
        .collection("passwords")
        .document(userPhone)
        .updateData({websiteName: encr});
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

                _updatePassword();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Passwords(userPhone: this.userPhone,);
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
