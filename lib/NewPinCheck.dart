import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_pass/Home.dart';
import 'PinEntry.dart';

class NewPinCheck extends StatefulWidget {
  NewPinCheck({Key key, this.title, this.prevpin}) : super(key: key);
  final String title;
  final String prevpin;

  @override
  _NewPinCheckState createState() => _NewPinCheckState();
}

class _NewPinCheckState extends State<NewPinCheck> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PinEntryTextField(
            onSubmit: (String pin){
              if(pin == widget.prevpin)
              {
                _auth.currentUser().then((user) {
                  databaseReference.collection("pins").document(user.phoneNumber).setData({'pin' : pin});
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  //print(user.phoneNumber);
                  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Passwords()));
                });
              }
              else
              {
                showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Pin"),
                      content: Text("Mismatching pins entered. Please check"),
                    );
                  }
                ); //end showDialog()
              }

            }, // end onSubmit
          ),
    );
  }

}
