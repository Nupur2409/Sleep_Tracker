import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sleeptracker/progress/viewnote.dart';


import 'addnote.dart';

class TalkSomeone extends StatefulWidget {
  const TalkSomeone({super.key});

  @override
  State<TalkSomeone> createState() => _TalkSomeoneState();
}

class _TalkSomeoneState extends State<TalkSomeone> {
 CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');

  List<Color> myColors = [
   Colors.red,
  Colors.green,
  Colors.deepPurple,
  Colors.purple,
  Colors.cyan,
  Colors.teal,
  Colors.tealAccent,
  Colors.pink,

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Color(0xffdce6f4),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          )
              .then((value) {
            print("Calling Set  State !");
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff102038)
      ),
      //
      appBar: AppBar(
        title: Text(
          "PROGRESS",
          style: TextStyle(
            fontSize: 32.0,
            fontFamily: GoogleFonts.ptSerif().fontFamily,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xffdce6f4),
      ),
      //
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length == 0) {
              return Center(
                child: Text(
                  "You have no saved Notes !",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Random random = new Random();
                Color bg = myColors[random.nextInt(4)];
                Map? data = snapshot.data?.docs[index].data() as Map;
                DateTime mydateTime = data['created']?.toDate();
                String formattedTime =
                    DateFormat.yMMMd().add_jm().format(mydateTime);

                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => ViewNote(
                          data,
                          formattedTime,
                          snapshot.data!.docs[index].reference,
                        ),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Card(
                    color: bg,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data['title']}",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontFamily: GoogleFonts.breeSerif().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          //
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattedTime,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: GoogleFonts.alegreya().fontFamily,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}