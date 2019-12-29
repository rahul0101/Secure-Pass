

import 'package:flutter/material.dart';

import './ViewWebSite.dart';
import './AddWebsite.dart';

void main()
{
  runApp(MaterialApp(home:
  Passwords()));
}
class Passwords extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PasswordsState();
  }
}
class PasswordsState extends State<Passwords>
{
  load() async
  {


  }
  void  _deletePassword()
  {
    setState(() {
    });
  }

  var WebsiteNames=["FaceBook","Twitter","Instagram"];





  Widget build (BuildContext context)
  {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87,title:Text('Home'),
        textTheme: TextTheme(title: TextStyle(color: Colors.greenAccent,fontSize:20),
        ),),

      body:SingleChildScrollView(child: Column(children: <Widget>[


        ...(WebsiteNames as List<String>).map((answer){
          return Container(
              width: double.infinity,
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 5),
              child:Card(
                  color: Colors.black87,
                  elevation: 5,
                child:ListTile(
                  onTap:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context){
                        return ViewWebSite(answer,WebsiteNames);
                      }),
                    ).then((val)=>val?load():null);
                  },
                title: Text(answer,
                    style:
                    TextStyle(color:Colors.greenAccent),
                    textAlign: TextAlign.center,textScaleFactor: (2)),
              )
              ) );}
        ).toList(),



      ]


        ,),),


      floatingActionButton: FloatingActionButton(

        // Within the `FirstRoute` widget
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return AddWebsite(WebsiteNames);
            }),
          ).then((val)=>val?load():null);
        },

        tooltip: 'Increment',
        child: Icon(Icons.add,size: 35.5,),),   ),


    );
  }

}