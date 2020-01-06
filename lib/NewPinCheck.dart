import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steel_crypt/steel_crypt.dart';
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
    final header = RichText(
      text: TextSpan(
        text: 'Confirm PIN' ,style: TextStyle(color: Colors.black, fontSize: 24),
      ),
    );

    _storeKey(String k, String i) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('key', k);
      prefs.setString('iv', i);
    }

    final pinbox = PinEntryTextField(
            onSubmit: (String pin){
              if(pin == widget.prevpin)
              {
                _auth.currentUser().then((user) {
                  var key = CryptKey().genFortuna();
                  var ivsalt = CryptKey().genDart(16);
                  _storeKey(key, ivsalt);
                  var encrypter = AesCrypt(key, 'cbc', 'iso10126-2');
                  String encr = encrypter.encrypt(pin,ivsalt);
                  databaseReference.collection("pins").document(user.phoneNumber).setData({'pin' : encr});
                  databaseReference.collection("passwords").document(user.phoneNumber).setData({'misc' : 'misc'});
                  databaseReference.collection('passwords').document(user.phoneNumber).updateData({'misc': FieldValue.delete()});
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  //print(user.phoneNumber);
                  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Passwords(userPhone: user.phoneNumber)));
                  
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
              if(pin == widget.prevpin)
              {
                _auth.currentUser().then((user) {
                  databaseReference.collection("pins").document(user.phoneNumber).setData({'pin' : pin});
                  databaseReference.collection("passwords").document(user.phoneNumber).setData({'misc' : 'misc'});
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
*/
