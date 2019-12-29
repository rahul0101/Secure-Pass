import 'package:flutter/material.dart';
class ViewWebSite extends StatelessWidget {
final String WebSiteName;
final List<String> WebsiteNames;


ViewWebSite(this.WebSiteName,this.WebsiteNames);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87,title:Text('AddWebsite'),
      textTheme: TextTheme(title: TextStyle(color: Colors.greenAccent,fontSize:20),
      ),),
  body: Column(
              children: <Widget>[
              SizedBox(
                width: double.infinity,
               child: Card(
                elevation: 5,

                child: Text("PassWord"
                    ,style: TextStyle(color: Colors.green) ,
                  textScaleFactor: 2.5,textAlign: TextAlign.center,),
              ),),
      SizedBox(
        width: double.infinity,
        child: Card(

                margin: EdgeInsets.all(10),
                elevation: 5,
                child:Text("sandeep",style: TextStyle(color: Colors.green) ,
                  textScaleFactor: 2.5,textAlign: TextAlign.center,

                )
              )
              ),

      RaisedButton(child:Text('delete'),
        // Within the SecondRoute widget
        onPressed: () {
          WebsiteNames.remove(WebSiteName);

          Navigator.pop(context,true
         );
        },),

                RaisedButton(child:Text('edit'),
                  // Within the SecondRoute widget
                  onPressed: () {
                 null;
                  },),       ],

              )
                                    ,),
    );
  }
}
