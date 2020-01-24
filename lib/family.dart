import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Family extends StatefulWidget {

  FirebaseUser user;

  Family(user) {
    this.user = user;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FamilyState(this.user);
  }
}

class FamilyState extends State<Family> {

  FirebaseUser user;

  FamilyState(user) {
    this.user = user;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello"
        ),
      ),
      body: mediminder(),
    );
  }

  Widget mediminder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        Flexible(
          child: StreamBuilder(
              stream: FirebaseDatabase.instance.reference().child("Users").child("IHDidXR5OTNcZLgLgVOpP4R7Qo52")
                            .child("Family").onValue,
              builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData) {
                  Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

                  print("ffdff");

                  if(map == null) {
                    return Center(
                      child: Text(
                        "No Mediminders Added Yet :)"
                      ),
                    );
                  }

                  print(map.keys);

                  //map.forEach((dynamic, v) => print(v["pic"]));

                  


                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: map.values.toList().length,
                      padding: EdgeInsets.all(2.0),
                      itemBuilder: (BuildContext context, int index) {

                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: Card(
                              elevation: 10,
                              child: ListView(

                                children: <Widget>[

                                  

                                  Center(
                                    child: Text(
                                      map.keys.elementAt(index),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Special'
                                      ),
                                    ),
                                  ),

                                  Center(
                                    child: Text(
                                        map.values.elementAt(index).toString()
                                    ),
                                  ),


                                  // Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.stretch,
                                  //   children: <Widget>[
                                  //     IconButton(
                                  //       icon: Icon(Icons.more_horiz),
                                  //       onPressed: () {
                                  //         showDialog(
                                  //             context: context,
                                  //             builder: (BuildContext context) => CupertinoPopupSurface(
                                  //                 child: ListView(
                                  //                   children: <Widget>[
                                  //                     Column(
                                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                                  //                       children: <Widget>[
                                  //                         Padding(
                                  //                           padding: EdgeInsets.only(top: 20),
                                  //                           child: SizedBox(
                                  //                             height: 50,
                                  //                             child: RaisedButton(
                                  //                               child: Icon(CupertinoIcons.back),
                                  //                               color: Colors.amber,
                                  //                               onPressed: () {
                                  //                                 Navigator.of(context, rootNavigator: true).pop();
                                  //                               },
                                  //                               shape: CircleBorder(
                                  //                                 side: BorderSide(
                                  //                                   style: BorderStyle.solid,
                                  //                                 ),
                                  //                               ),
                                  //                             ),
                                  //                           ),
                                  //                         )
                                  //                       ],
                                  //                     ),

                                  //                     Padding(
                                  //                       padding: EdgeInsets.all(30),
                                  //                     ),

                                                      

                                  //                     Padding(
                                  //                       padding: EdgeInsets.all(10),
                                  //                     ),

                                  //                     Card(
                                  //                       child: ListTile(
                                  //                         title: Text(
                                  //                           "Medicine Name",
                                  //                           style: TextStyle(
                                  //                               fontWeight: FontWeight.bold
                                  //                           ),
                                  //                         ),
                                  //                         subtitle: Text(
                                  //                             map.values.elementAt(index)['mediname']
                                  //                         ),
                                  //                       ),
                                  //                     ),

                                  //                     Padding(
                                  //                       padding: EdgeInsets.all(5),
                                  //                     ),

                                  //                     Card(
                                  //                       child: ListTile(
                                  //                         title: Text(
                                  //                           "Medicine Type",
                                  //                           style: TextStyle(
                                  //                               fontWeight: FontWeight.bold
                                  //                           ),
                                  //                         ),
                                  //                         subtitle: Text(
                                  //                             map.values.elementAt(index)['type']
                                  //                         ),
                                  //                       ),
                                  //                     ),

                                  //                     Padding(
                                  //                       padding: EdgeInsets.all(5),
                                  //                     ),

                                  //                     Card(
                                  //                       child: ListTile(
                                  //                         title: Text(
                                  //                           "Dosage",
                                  //                           style: TextStyle(
                                  //                               fontWeight: FontWeight.bold
                                  //                           ),
                                  //                         ),
                                  //                         subtitle: Text(
                                  //                             map.values.elementAt(index)['dosage'] + " mg"
                                  //                         ),
                                  //                       ),
                                  //                     ),

                                  //                     Padding(
                                  //                       padding: EdgeInsets.all(5),
                                  //                     ),

                                  //                     Card(
                                  //                       child: ListTile(
                                  //                         title: Text(
                                  //                           "Duration",
                                  //                           style: TextStyle(
                                  //                               fontWeight: FontWeight.bold
                                  //                           ),
                                  //                         ),
                                  //                         subtitle: Text(
                                  //                             "Every "+map.values.elementAt(index)['interval']
                                  //                                 +" Hours"
                                  //                         ),
                                  //                       ),
                                  //                     ),

                                  //                     Padding(
                                  //                       padding: EdgeInsets.all(5),
                                  //                     ),

                                  //                     Center(
                                  //                       child: RaisedButton(
                                  //                         child: Text(
                                  //                           "Delete this Medicine",
                                  //                           style: TextStyle(
                                  //                               color: Colors.white
                                  //                           ),
                                  //                         ),
                                  //                         color: Colors.red,
                                  //                         onPressed: () {
                                  //                           showDialog(
                                  //                               context: context,
                                  //                               builder: (BuildContext context) => CupertinoAlertDialog(
                                  //                                 title: Text(
                                  //                                   "Are You sure you want to delete this medicine",
                                  //                                   style: TextStyle(
                                  //                                       fontSize: 20.0,
                                  //                                       color: Colors.red
                                  //                                   ),
                                  //                                 ),
                                  //                                 actions: <Widget>[
                                  //                                   CupertinoActionSheetAction(
                                  //                                     onPressed: () {

                                  //                                     },
                                  //                                     child: CupertinoButton(
                                  //                                         color: Colors.red,
                                  //                                         child: Text(
                                  //                                           "Delete",
                                  //                                           style: TextStyle(
                                  //                                               color: Colors.black
                                  //                                           ),
                                  //                                         ),
                                  //                                         onPressed: () {
                                  //                                           Navigator.pop(context);
                                  //                                           Navigator.pop(context);

                                                                            

                                  //                                           setState(() {

                                  //                                           });
                                  //                                         }
                                  //                                     ),
                                  //                                   ),

                                  //                                   CupertinoActionSheetAction(
                                  //                                     onPressed: () {

                                  //                                     },
                                  //                                     child: CupertinoButton(

                                  //                                         color: Colors.amber,
                                  //                                         child: Text(
                                  //                                           "Cancel",
                                  //                                           style: TextStyle(
                                  //                                               color: Colors.black
                                  //                                           ),
                                  //                                         ),
                                  //                                         onPressed: () {
                                  //                                           Navigator.of(context).pop();
                                  //                                         }
                                  //                                     ),
                                  //                                   ),
                                  //                                 ],
                                  //                               )
                                  //                           );
                                  //                         },
                                  //                         shape: OutlineInputBorder(
                                  //                             borderRadius: BorderRadius.circular(30)
                                  //                         ),
                                  //                       ),
                                  //                     )



                                  //                   ],
                                  //                 )
                                  //             )
                                  //         );
                                  //       },
                                  //     )
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                          )
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),


      ],
    );
  }

}