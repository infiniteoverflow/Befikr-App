import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_database/firebase_database.dart';


class SignUpPage extends StatefulWidget  {
@override
   _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name,phone,mail,pass;

 GlobalKey<FormState> _key = new GlobalKey();
   bool autovalidate=false;
   
  var databaseRef = FirebaseDatabase.instance.reference();

  // Toggles the password show status
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:
         Form(key: _key,
          child:  Column(mainAxisAlignment: MainAxisAlignment.end,
            
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Image(
                  image: AssetImage(
                    "assets/image_01.png"
                  ),
                  width: 250.0,
                  height: 250.0,
                ),
                ListTile(
                  leading: Icon(Icons.person,color: Colors.amber,),
                  title: TextFormField(
                    
                    textCapitalization: TextCapitalization.sentences,
                    validator: (input){
                      if(input.isEmpty){
                        return "Enter Name";
                      }
                      
                    },
                    decoration: InputDecoration(border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 200.0),
                    ),labelText: "Name",labelStyle: TextStyle(color: Colors.black)),
                    onSaved:(input)=>name=input ,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),

                ListTile(
                  leading: Icon(Icons.mail,color: Colors.red,),
                  title: TextFormField(
                    validator: (input){
                      if(input.isEmpty){
                        return "Enter Mail Id";
                      }
                      
                    },
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Mail",labelStyle: TextStyle(color: Colors.black)),
                    onSaved:(input)=>mail=input ,

                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),

                ListTile(
                  leading: Icon(Icons.phone_android,color: Colors.green,),
                  title: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (input){
                      if(input.isEmpty){
                        return "Enter Mobile number";
                      }
                      
                    },
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: "MobileNumber",labelStyle: TextStyle(color: Colors.black)),
                    onSaved:(input)=>phone=input ,

                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),

                ListTile(
                  leading: Icon(Icons.security,color: Colors.orange),
                  title: TextFormField(
                    obscureText: true,
                    
                       validator: (input) => input.length < 6 ? 'Password too short.' : null,
                      
                    
                    decoration: InputDecoration(labelText: "Password",labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder()),
                    onSaved:(input)=>pass=input ,
                   
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.amber,
                                Colors.red
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text("Go Back",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      ),

                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _sendtonextPage();
                              },
                              child: Center(
                                child: Text("Submit",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                )
              ],
              
            ),
          ),
        ),
        
        

      

    );

       
  }
  _sendtonextPage() async{

    if(_key.currentState.validate()){
      _key.currentState.save();
      AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail, password: pass);
      FirebaseUser user = result.user;

      databaseRef.child("Users").child(user.uid).set({
        'Name':name,
        'Phone':phone,
        'Email':mail,
        'location': {
          'Latitude': 0.0,
          'Longitude': 0.0,
        },
        'user Verified':0
    });

      Navigator.pop(context);
    }
    else {
      setState(() {
        autovalidate = true;
      });

       }
}}