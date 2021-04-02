import 'dart:async';
import 'package:edc_pict/database.dart';
import 'package:edc_pict/home.dart';
import 'key.dart';
import 'package:edc_pict/toggle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


class verify extends StatefulWidget {



  @override
  _verifyState createState() => _verifyState();
}

class _verifyState extends State<verify> {

  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;
  String id = "";
  String name = "";
  String surname = "";
  String Class = "Class";
  String Division = "Division";
  String branch = "Branch";
  String error = '';
  String pic = " ";
  String uid = key;
  bool admin = false;
  Color color = Colors.red;
  Container cont = Container();
  bool avat = false;
  String email;


  final _formkey = GlobalKey<FormState>();



  @override
  void initState() {
    // TODO: implement initState
    print("initstate");
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    double query = MediaQuery.of(context).size.height;
    double query1 = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[100],
        leading: FlatButton(
          child: Icon(Icons.arrow_back),
          onPressed: ()
          {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Toggle()));
          },
        ),
      ),
      backgroundColor: Colors.blue[100],
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width*0.83,
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  Text("Enter Details",style: GoogleFonts.openSans(color: Colors.blue[900],fontSize: 30,fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                  // SizedBox(height: 15,),
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue[900], width: 2),
                            borderRadius: BorderRadius.circular(30)),
                        hintText: "First Name"),
                    validator: (val) => val.isEmpty ? "Enter an email" : null,
                    onChanged: (val) {
                        name = val;
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue[900], width: 2),
                            borderRadius: BorderRadius.circular(30)),
                        hintText: "Last Name"),
                    validator: (val) => val.isEmpty ? "Enter an email" : null,
                    onChanged: (val) {
                      surname = val;
                    },
                  ),
                  SizedBox(height: 15,),
                  Row(
                      children: [
                          Container(
                            width: query1*0.4,
                            height: 60,
                            padding: EdgeInsets.all(17),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white
                            ),
                            child: DropdownButton<String>(
                              value: Class,
                              isExpanded: true,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 0,
                              isDense: true,
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 17),
                              underline: Container(
                                height: 0,
                                width: 0,
                                color: Colors.white,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  Class = newValue;
                                });
                              },
                              items: <String>["Class",'FE', 'SE', 'TE', 'BE']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        SizedBox(width: 5,),
                        Container(
                          width: query1*0.4,
                          height: 60,
                          padding: EdgeInsets.all(17),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white
                          ),
                          child: DropdownButton<String>(
                            value: Division,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 0,
                            isDense: true,
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 17),
                            underline: Container(
                              height: 0,
                              width: 100,
                              color: Colors.white,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                Division = newValue;
                              });
                            },
                            items: <String>["Division",'1', '2', '3', '4','5','6','7','8','9','10','11']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 15,),
                  Container(
                    width: query1*0.82,
                    height: 60,
                    padding: EdgeInsets.all(17),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                    ),
                    child: DropdownButton<String>(
                      // iconEnabledColor: Colors.blue,
                      value: branch,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 0,
                      isDense: true,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 17),
                      underline: Container(
                        height: 0,
                        width: 0,
                        color: Colors.white,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          branch = newValue;
                        });
                      },
                      items: <String>["Branch",'Computer Engineering', 'Information Technology', 'EnTC Engineering']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 15,),

                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue[900], width: 2),
                            borderRadius: BorderRadius.circular(30)),
                        hintText: "Unique ID (Only for admin login)"),
                    validator: (val) => val.isEmpty ? "Enter an email" : null,
                    onChanged: (val) {
                        if(val==uid)
                          {
                            admin = true;
                          }
                    },
                  ),

                  SizedBox(height: 15,),
                  RaisedButton(
                    child: Text("Choose Avatar",style: GoogleFonts.openSans(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.w600),),
                    color: Colors.blue[900],
                    onPressed:()
                    {
                      avat = !avat;
                      if(avat)
                        {
                          setState(() {
                            cont = Container(
                              // color: Colors.white,
                              // padding: EdgeInsets.fromLTRB(0,10,0,10),
                              height: query*0.25,
                              width: query1*0.9,
                              child: Column(
                                children: [
                                  Row(
                                    // mainAxisAlignment:MainAxisAlignment.space
                                    children: [
                                      Container(
                                        width:query1*0.2,
                                        child: RawMaterialButton(
                                            onPressed: () {pic = "assets/b1.svg";
                        },
                                            elevation: 2.0,
                                            fillColor: Colors.white,
                                            child: SvgPicture.asset("assets/b1.svg",height: query*0.095,),
                                          padding: EdgeInsets.all(7.0),
                                          shape: CircleBorder(),
                                          focusColor: Colors.blue[900],
                                          splashColor: Colors.yellow,

                                        ),
                                      ),
                                      SizedBox(width: query1*0.008,),
                                      Container(
                                        width:query1*0.2,
                                        child: RawMaterialButton(
                                          onPressed: () {pic = "assets/b2.svg";},
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          child: SvgPicture.asset("assets/b2.svg",height: query*0.095),
                                          padding: EdgeInsets.all(7.0),
                                          shape: CircleBorder(),
                                          splashColor: Colors.yellow,
                                        ),
                                      ),
                                      SizedBox(width: query1*0.008,),

                                      Container(
                                        width:query1*0.2,
                                        child: RawMaterialButton(
                                          onPressed: () {pic = "assets/b3.svg";},
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          child: SvgPicture.asset("assets/b3.svg",height: query*0.095),
                                          padding: EdgeInsets.all(7.0),
                                          shape: CircleBorder(),
                                          splashColor: Colors.yellow,
                                        ),
                                      ),
                                      SizedBox(width: query1*0.008,),

                                      Container(
                                        width:query1*0.2,
                                        child: RawMaterialButton(
                                          onPressed: () {pic = "assets/b4.svg";},
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          child: SvgPicture.asset("assets/b4.svg",height: query*0.095),
                                          padding: EdgeInsets.all(7.0),
                                          shape: CircleBorder(),
                                          splashColor: Colors.yellow,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: query1*0.008,),
                                  Row(
                                    children: [
                                      Container(
                                        width:query1*0.2,
                                        child: RawMaterialButton(
                                          onPressed: () {pic = "assets/g1.svg";},
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          child: SvgPicture.asset("assets/g1.svg",height: query*0.095),
                                          padding: EdgeInsets.all(7.0),
                                          shape: CircleBorder(),
                                          focusColor: Colors.blue[900],
                                          splashColor: Colors.yellow,
                                        ),
                                      ),
                                      SizedBox(width: query1*0.008,),
                                      Container(
                                        width:query1*0.2,
                                        child: RawMaterialButton(
                                          onPressed: () {pic = "assets/g2.svg";},
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          child:SvgPicture.asset("assets/g2.svg",height: query*0.095),
                                          padding: EdgeInsets.all(7.0),
                                          shape: CircleBorder(),
                                          splashColor: Colors.yellow,
                                        ),
                                      ),
                                      SizedBox(width:query1*0.008,),

                                      Container(
                                        width:query1*0.2,
                                        child: RawMaterialButton(
                                          onPressed: () {pic = "assets/g3.svg";},
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          child: SvgPicture.asset("assets/g3.svg",height: query*0.095),
                                          padding: EdgeInsets.all(7.0),
                                          shape: CircleBorder(),
                                          splashColor: Colors.yellow,
                                        ),
                                      ),
                                      SizedBox(width: query1*0.008,),

                                      Container(
                                        width:query1*0.2,
                                        child: RawMaterialButton(
                                          onPressed: () {pic = "assets/g4.svg";},
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          child: SvgPicture.asset("assets/g4.svg",height: query*0.095),
                                          padding: EdgeInsets.all(7.0),
                                          shape: CircleBorder(),
                                          splashColor: Colors.yellow,
                                        ),
                                      ),




                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                        }
                      else
                        {
                          setState(() {
                            cont = Container();
                          });
                        }
                    },
                  ),
                  cont,
                  SizedBox(height: MediaQuery.of(context).size.height*0.007,),
                  RaisedButton(
                    child: Text("Verify Email",style: GoogleFonts.openSans(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.w600),),
                    color: Colors.blue[900],
                    onPressed: ()
                    {
                      if(Division.isNotEmpty && name.isNotEmpty && Class.isNotEmpty && branch.isNotEmpty && surname.isNotEmpty)
                        {
                          Database db = Database(user.uid);
                          String a = " ";
                          // Map<int,int> b = {1:1};
                          db.updateDetails(name+" "+surname, Division, Class, branch,0,0,0,0,admin,pic,false,false,a,user.email,false);
                          user = auth.currentUser;
                          user.sendEmailVerification();
                            error = "Email verification link sent to your registered email-id.";
                            color = Colors.black45;
                            return showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    "Note!",
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
                        }
                      else
                        {
                            error = "Enter all the credentials.";
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
                        }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async
  {
    user = auth.currentUser;
    user.reload();



    if(user.emailVerified)
      {
        timer.cancel();
        print("verified");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      }
  }

}
