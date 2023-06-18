import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
 late String title;
  late String des;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold( backgroundColor: Color(0xffb0c6e7),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(
              12.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 24.0,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xff0c192c)
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    ),
                    //
                    ElevatedButton(
                      onPressed: add,
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "lato",
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xff0c192c)
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //
                SizedBox(
                  height: 12.0,
                ),
                //
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Title",
                        ),
                        style: TextStyle(
                          fontSize: 35.0,
                          fontFamily: GoogleFonts.alegreya().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                        onChanged: (_val) {
                          title = _val;
                        },
                      ),
                      //
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(
                            hintText: "Note Description",
                          ),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "lato",
                            color: Colors.black
                          ),
                          onChanged: (_val) {
                            des = _val;
                          },
                          maxLines: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');

    var data = {
      'title': title,
      'description': des,
      'created': DateTime.now(),
    };

    ref.add(data);

    //

    Navigator.pop(context);
  }
}
