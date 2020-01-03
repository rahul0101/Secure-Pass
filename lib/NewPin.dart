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
    final header = RichText(
      text: TextSpan(
        text: 'Enter PIN' ,style: TextStyle(color: Colors.black, fontSize: 24),
      ),
    );

    final pinbox = PinEntryTextField(
            onSubmit: (String pin){
              Navigator.of(context).push(MaterialPageRoute(builder:(context)=>NewPinCheck(prevpin:pin)));
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

          */
