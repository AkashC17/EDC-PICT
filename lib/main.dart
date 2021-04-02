import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:edc_pict/authenticate.dart';
import 'package:edc_pict/wrapper.dart';
import 'package:edc_pict/user.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if(_error) {
      return SomethingWentWrong();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Loading();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: app()
    );
  }
}

class app extends StatefulWidget {
  @override
  _appState createState() => _appState();
}

class _appState extends State<app> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations(
        [ DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.22,),
            Container(
              height: MediaQuery.of(context).size.height*0.7,
              child: SplashScreen(
                seconds: 2,
                navigateAfterSeconds: MyApp(),
                title: new Text(
                  'PICT ENTREPRENEURSHIP DEVELOPMENT CELL',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(textStyle:TextStyle(fontWeight: FontWeight.w600, fontSize: MediaQuery.of(context).size.width*0.05,color: Colors.blue[900]),)
                ),
                image: Image.asset("assets/LOGO.jpg",),
                photoSize: MediaQuery.of(context).size.width*0.32,
                backgroundColor: Colors.white,
                loaderColor: Colors.blue[900],
                // loadingText: Text("Loading"),
                useLoader: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: Auth().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.blue[100],

      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.yellow
    );
  }
}


