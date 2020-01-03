import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './ChangePassword.dart';

class ViewWebSite extends StatelessWidget {
  final String webSiteName;
  final String password;
  final userPhone;

  ViewWebSite(this.webSiteName, this.password, this.userPhone);
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
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Text(
                  "Password",
                  style: TextStyle(color: Colors.green),
                  textScaleFactor: 2.5,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
                width: double.infinity,
                child: Card(
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    child: Text(
                      password,
                      style: TextStyle(color: Colors.green),
                      textScaleFactor: 2.5,
                      textAlign: TextAlign.center,
                    ))),
            RaisedButton(
              child: Text('delete'),
              // Within the SecondRoute widget
              onPressed: () {
                try {
                  Firestore.instance
                      .collection('passwords')
                      .document(userPhone)
                      .updateData(
                          {webSiteName: FieldValue.delete()}).whenComplete(() {
                    print('Field Deleted');
                  });
                  Navigator.pop(context, true);
                } catch (e) {
                  print(e.toString());
                }
              },
            ),
            RaisedButton(
              child: Text('edit'),
              // Within the SecondRoute widget
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ChangePassword(webSiteName, userPhone);
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
