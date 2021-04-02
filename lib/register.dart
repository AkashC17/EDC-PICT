import 'package:edc_pict/verify.dart';
import 'package:flutter/material.dart';
import 'package:edc_pict/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Register extends StatefulWidget {
  Function toggleview;
  Register({this.toggleview});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String password = "";
  String error = ' ';
  bool loading = false;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Auth _auth = Auth();
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser;
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        title: Text(
          'Sign Up',
          style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.green[900],fontSize: MediaQuery.of(context).size.width*0.07),fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.08, vertical: MediaQuery.of(context).size.height*0.03),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Lottie.asset("assets/l4.json",height: MediaQuery.of(context).size.height*0.25),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: MediaQuery.of(context).size.height*0.003),
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green[900], width: MediaQuery.of(context).size.height*0.003),
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.1)),
                        border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green[900], width: MediaQuery.of(context).size.height*0.003),
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.1)),
                        hintText: "Email-id"),
                    validator: (val) => val.isEmpty ? "Enter an email" : null,
                    onChanged: (val) {
                        email = val;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.025,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: MediaQuery.of(context).size.height*0.003),
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green[900], width: MediaQuery.of(context).size.height*0.003),
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.1)),
                        border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green[900], width: MediaQuery.of(context).size.height*0.003),
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.1)),
                        hintText: "Password"),
                    obscureText: true,
                    validator: (val) =>
                        val.length < 6 ? "Enter a strong password" : null,
                    onChanged: (val) {
                        password = val;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.025,
                  ),
                  RaisedButton(
                      color: Colors.green[700],
                      child: Text(
                        'Register',
                        style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.w600)),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == _auth.error) {
                              loading = false;
                              error = _auth.error;
                            return showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    "Warning!",
                                  ),
                                  content: Text(error),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Ok',
                                      ),
                                    )
                                  ],
                                ));
                          } else {
                            // Database db = Database(FirebaseAuth.instance.currentUser.uid);
                            // db.updateEmailId(email);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => verify()));
                            print(result);
                          }
                        }
                      }),
                  FlatButton(onPressed:() =>  widget.toggleview(),
                      child: Text("Already have an account? Sign In",style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.green[900],fontSize: MediaQuery.of(context).size.height*0.019,fontWeight: FontWeight.w600))))
                ],
              ),
            )),
      ),
    );
  }
}
