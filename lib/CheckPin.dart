import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_pass/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'PinEntry.dart';

class CheckPin extends StatefulWidget {
  CheckPin({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CheckPinState createState() => _CheckPinState();
}

class _CheckPinState extends State<CheckPin> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;
  @override
  Widget build(BuildContext context) {

    final header = RichText(
      text: TextSpan(
        text: 'Enter PIN' ,style: TextStyle(color: Colors.black, fontSize: 24),
      ),
    );

    _checkPin(String x, String pin, String phone) async
    {
      final prefs = await SharedPreferences.getInstance(); 
      String key = prefs.getString('key');
      String iv = prefs.getString('iv');
      var encrypter = AesCrypt(key, 'cbc', 'iso10126-2');
      String result = encrypter.decrypt(x, iv);
      if(result == pin)
      {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Passwords(userPhone: phone)));
      }
      else
      {
        showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Pin"),
              content: Text('Incorrect pin!'),
            );
          }
        );
      }
    }

    final pinbox = PinEntryTextField(
            onSubmit: (String pin){
              _auth.currentUser().then((user) {
                print('u' + user.phoneNumber);
                Firestore.instance.collection('pins').document(user.phoneNumber).get().then((document){
                  final val = document.data['pin'].toString();
                  _checkPin(val, pin, user.phoneNumber);
                });
              }); //end showDialog()

            }, // end onSubmit
          );

    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                header,
                SizedBox(
                  height: 48.0,
                ),
                pinbox,
                SizedBox(
                  height: 32.0,
                )
              ],
            ),
          ),
        ),
      )
    );
  }

}

/*
PinEntryTextField(
            onSubmit: (String pin){
              _auth.currentUser().then((user) {
                print(user.phoneNumber);
                Firestore.instance.collection('pins').document(user.phoneNumber).get().then((document){
                  //print(document.data);
                  final x = document.data['pin'].toString();
                  //print(x + '   ' + pin);
                  if(x == pin)
                  {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Passwords()));
                  }
                  else
                  {
                    showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("Pin"),
                          content: Text('Incorrect pin!'),
                        );
                      }
                    );
                  }
                });
              }); //end showDialog()

            }, // end onSubmit
          ),
          */