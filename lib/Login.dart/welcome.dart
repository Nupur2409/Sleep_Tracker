import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleeptracker/Login.dart/loginscreen.dart';
import 'package:sleeptracker/Login.dart/signupscreen.dart';



class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(  
        child: SingleChildScrollView(
          child: 
        
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 50),
              child: Center(
                child: Text(
                  "Sleep Tracker",
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
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 30),
                child: Center(
                    child: Text("A place to feel better, wherever you go.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: GoogleFonts.lora().fontFamily)))),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              child: Image.asset(
                'assets/images/sleep.png',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: Center(
                    child: Text(
                        "Sleep tracking devices can measure sleep duration, efficiency, and wake up times to provide insight into sleep quality and identify potential issues.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17)))),
            Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(15),
                child: Center(
                    child: Text(
                  "Improve your SLEEP TRACKING in the most convenient and affordable way!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ))),
            Container(
                margin: EdgeInsets.all(5),
                width: 200,
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.black))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff0d2241)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text('Sign Up'),
                )),
            Container(
              margin: EdgeInsets.all(5),
              child: RichText(
                text: TextSpan(
                  text: 'Already Have An Account? ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: 'Log In',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()),
                              ),
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}