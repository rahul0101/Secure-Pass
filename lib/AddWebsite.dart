import 'package:flutter/material.dart';
import 'Home.dart';
class AddWebsite extends StatelessWidget {
//String WebsiteName;
//String Password;
//String ConfirmPassword;
var WebsiteNames;

AddWebsite(this.WebsiteNames);

// Within the SecondRoute widget


final WebsiteNameController=TextEditingController();
final PasswordController=TextEditingController();
final ConfirmPasswordsController=TextEditingController();
  @override
  Widget build(BuildContext context)
  {
     return MaterialApp(home: Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87,title:Text('AddWebsite'),
      textTheme: TextTheme(title: TextStyle(color: Colors.greenAccent,fontSize:20),
      ),),
     body: Column(
       children: <Widget>[

           Container(
             width:double.infinity,
             margin:EdgeInsets.all(10),

                child:Column(
                    children: <Widget>[
                             Card(
                             elevation: 5,
                  child:TextField(decoration: InputDecoration(labelText: ' WebsiteName' ),
                               // onChanged: (val){WebsiteName=val;},
                                      controller: WebsiteNameController,),),
               Card(
                 elevation: 5,
                 child:TextField(decoration: InputDecoration(labelText: ' password'),
                              //onChanged: (val){Password=val;},
                                controller: PasswordController,),),
                              Card(
                              elevation: 5,
  child: TextField(decoration: InputDecoration(labelText: ' ConfirmPassword'),
                              //  onChanged:(val){ConfirmPassword=val;},
                             controller: ConfirmPasswordsController, ),)
                                      ],
                              )

         ),
               RaisedButton(child:Text('Create'),
                 // Within the SecondRoute widget
                 onPressed: () {
                    WebsiteNames.add(WebsiteNameController.text);
                   Navigator.pop(context,true);
                 },
               elevation: 5,
               shape: RoundedRectangleBorder(
                 borderRadius: new BorderRadius.circular(18.0),
                 side: BorderSide(color: Colors.black87,),),
               textColor: Colors.greenAccent,
               )         ],

                  ),
     ),
     );



  }
}
