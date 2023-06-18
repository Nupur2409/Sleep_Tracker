import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  //editing controllers
  final TextEditingController _emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailfield = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter email';
        }
        //regex for email
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      autofocus: false,
      style: TextStyle(
        color: Colors.black,
      ),
      onSaved: (String? value) {
        _emailController.text = value!;
      },
      decoration: new InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: 'you@example.com',
          hintStyle: TextStyle(
            color: Colors.black,
          ),
          labelText: 'E-mail Address',
          labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
      textInputAction: TextInputAction.next,
    );
    final loginButton = Material(
      color: Color(0xff0d2241),
      elevation: 5.0,
      borderRadius: BorderRadius.circular(18.0),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
           FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailController.text)
                      .then((value) => Navigator.of(context).pop());
        },
        child: Text(
          "Reset Password",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );


    return Scaffold( backgroundColor: Colors.white,
        body: ListView(children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 50, top: 70, right: 50, bottom: 20),
            child: Center(
              child: Text(
                "Mental Health Analysis",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff000026),
                    fontFamily: GoogleFonts.libreBaskerville().fontFamily,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 3)
                    ]),
              ),
            ),
          ),
          
           Container(
              padding: EdgeInsets.all(0),
              child: Center(
                  child: Text(" Reset Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.lora().fontFamily,
                        color: Color(0xff0d2241),
                      )))),
                      Container(
                        padding: new EdgeInsets.all(20.0),
                         child: new Form(child: new ListView(
                          shrinkWrap: true,
                  children: <Widget>[
                     SizedBox(height: 40.0),
                    emailfield,
                    SizedBox(height: 15,),
                    loginButton,
                    SizedBox(height: 15.0), 
                    
                  ]
                         ),)
                      ),
             
                    
          ])
          
          
          
          );
  }
}
