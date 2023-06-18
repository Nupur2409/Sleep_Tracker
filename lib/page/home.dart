import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../Login.dart/welcome.dart';
import '../alarm/alarmclock.dart';
import '../model/usermodel.dart';
import '../progress/progress.dart';


class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  late int selectedRadioButton;

  final databaseReference = FirebaseDatabase.instance.reference();

  setSelectedRadioButton(int value) {
    setState(() {
      selectedRadioButton = value;
    });

    databaseReference.child("feeling").set({"feeling": value});
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users") //get the collection
        .doc(user!.uid) //get the user id
        .get() //getting all the values from the database
        .then((value) {
      this.loggedInUser = UserModel.fromMap(
          value.data()); //converting the data into a user model
      setState(() {}); //updating the state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff8f8f8),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage('assets/images/mm.jpg')),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
          ),
          Column(children: <Widget>[
            SizedBox(
              height: 90,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        'Sleep Tracker',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            fontFamily: GoogleFonts.alatsi().fontFamily),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    SingleChildScrollView(
                        child: Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Track Your Sleep',
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ])),
                        
                      ],
                    )
                    ),SizedBox(height: 75),
             Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 15,
                          spreadRadius: 1)
                    ]),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/download.jpg'))),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(text: TextSpan(
                             recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => alarm())),
                    text: "SET ALARM",  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff000026),
                      fontFamily: GoogleFonts.libreBaskerville().fontFamily,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 3
                          ) , ]))
                          )
                        ]
                      ),
                    ),
                    
                  ],
                  
                ),
                
              ),
             
              SizedBox(height: 75),
             Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 15,
                          spreadRadius: 1)
                    ]),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/p.jpg'))),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(text: TextSpan(
                             recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TalkSomeone())),
                    text: "PROGRESS",  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff000026),
                      fontFamily: GoogleFonts.libreBaskerville().fontFamily,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 3
                          ) , ]), 
                          ) , textAlign: TextAlign.center,
                          )
                        ]
                      ),
                    ),
                    
                  ],
                  
                ),
              ),
              SizedBox(height: 50,),

                Container( alignment: Alignment.center,
                child: Column(
              children: [
                ActionChip(
                  label: Text("Logout"),
                  onPressed: () => {
                    logout(context),
                  },
                  backgroundColor: Colors.black,
                  elevation: 10,
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)),
                  padding: EdgeInsets.all(15),
                ),]))
              
              
                  ]))
          )
        ])]));
  }
  //LOGOUT FUNCTION
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Welcome()));
  }

}
