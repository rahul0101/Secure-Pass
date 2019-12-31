import 'package:flutter/material.dart';
import 'PinEntry.dart';
import 'NewPinCheck.dart';

class NewPin extends StatefulWidget {
  NewPin({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NewPinState createState() => _NewPinState();
}

class _NewPinState extends State<NewPin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PinEntryTextField(
            onSubmit: (String pin){
              Navigator.of(context).push(MaterialPageRoute(builder:(context)=>NewPinCheck(prevpin:pin)));
              /*
              showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text("Pin"),
                    content: Text('Pin entered is $pin'),
                  );
                }
              ); //end showDialog()
              */
            }, // end onSubmit
          ),
    );
  }

}
