import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steel_crypt/steel_crypt.dart';

class AddWebsite extends StatelessWidget {
  final userPhone;
  final databaseReference = Firestore.instance;

  AddWebsite(this.userPhone);
// Within the SecondRoute widget

  _updatePassword() async {
    final prefs = await SharedPreferences.getInstance();
    var encrypter = AesCrypt(prefs.getString('key'), 'cbc', 'iso10126-2');
    String encr = encrypter.encrypt(passwordController.text,prefs.getString('iv'));
    databaseReference
        .collection("passwords")
        .document(userPhone)
        .updateData({websiteNameController.text: encr});
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
          title: Text('AddWebsite'),
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
                        decoration: InputDecoration(labelText: ' WebsiteName'),
                        // onChanged: (val){WebsiteName=val;},
                        controller: websiteNameController,
                      ),
                    ),
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
              child: Text('Create'),
              // Within the SecondRoute widget
              onPressed: () {
                _updatePassword();
                Navigator.pop(context, true);
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
