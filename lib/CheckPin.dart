import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_pass/Home.dart';
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
    return Scaffold(
      body: PinEntryTextField(
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
    );
  }

}
