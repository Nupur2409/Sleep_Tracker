import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../model/usermodel.dart';
import '../page/home.dart';
import 'loginscreen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _SignUpSreenState();
}

class _SignUpSreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  //form  key
  final _formKey = GlobalKey<FormState>();
  //editting controller
  final _nameController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _confirmPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
   
    //name field
    final namefield = TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      autofocus: false,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return 'Name cannot be empty';
        }
        //regex for email
        if (!regex.hasMatch(value)) {
          return ("Name must be at least 3 characters");
        }
        return null;
      },
      style: TextStyle(
        color: Colors.black,
      ),
      onSaved: (String? value) {
        _nameController.text = value!;
      },
      decoration: new InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: 'XYZ',
          hintStyle: TextStyle(
            color: Colors.black,
          ),
          labelText: 'Your Name',
          labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
      textInputAction: TextInputAction.next,
    );

    //email field
    final emailfield = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      style: TextStyle(
        color: Colors.black,
      ),
      onSaved: (String? value) {
        _emailController.text = value!;
      },
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

    final passwordfield = TextFormField(
        controller: _passwordController,
        autofocus: false,
        obscureText: true,
        onSaved: (String? value) {
          _passwordController.text = value!;
        },
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for SignUp");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: new InputDecoration(
            hintText: 'Password',
            prefixIcon: Icon(Icons.vpn_key),
            labelText: 'Enter your password',
            labelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )));

    final confirmpasswordfield = TextFormField(
        controller: _confirmPasswordController,
        autofocus: false,
        obscureText: true,
        onSaved: (String? value) {
          _passwordController.text = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return ("Password is required for SignUp");
          }
          if (value != _passwordController.text) {
            return ("Password does not match");
          }
          return null;
        },
        textInputAction: TextInputAction.done,
        decoration: new InputDecoration(
            hintText: 'Password',
            prefixIcon: Icon(Icons.vpn_key),
            labelText: 'Confirm password',
            labelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )));

    final signupButton = Material(
      color: Color(0xff09121b),
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () => {
          signUp(_emailController.text, _passwordController.text),
        },
        child: Text(
          "SignUp",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 50, top: 50, right: 50, bottom: 20),
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
              padding: EdgeInsets.all(0),
              child: Center(
                  child: Text("Get Started",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0d2241),
                      )))),
          Container(
              padding: new EdgeInsets.all(20.0),
              child: new Form(
                key: this._formKey,
                child: new ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    // We will add fields here.
                    SizedBox(height: 40.0),
                    namefield,
                    SizedBox(height: 20.0),
                    emailfield,
                    SizedBox(height: 20.0),
                    passwordfield,
                    SizedBox(height: 20.0),
                    confirmpasswordfield,
                    SizedBox(height: 40.0),
                    signupButton,
                  ],
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Center(
            child: RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pop(context,
                          MaterialPageRoute(builder: (context) => SignInScreen())),
                    text: "Have an account?",
                    style: TextStyle(fontSize: 20, color: Colors.grey[500]))),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.2,
          ),
          
         
        ]));
  }

  //signup function
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) => {
                Fluttertoast.showToast(
                    msg: e.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 20.0)
              });
    }
  }

  postDetailsToFirestore() async {
    //calling firestore
    //calling user model
    //sending the values to firestore

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    //setting the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = _nameController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(
        msg: "SignUp Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 20.0);
    //redirecting to home page
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false);
  }
}





