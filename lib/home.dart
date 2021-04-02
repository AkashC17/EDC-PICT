import 'package:edc_pict/toggle.dart';
import 'package:flutter/material.dart';
import 'package:edc_pict/authenticate.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int ind = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [Screen1(),Screen1(),Screen1(),Screen1()];


    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: ind,
          items: [BottomNavigationBarItem(label:"Screen 1",icon: Icon(Icons.smartphone)),BottomNavigationBarItem(label:"Screen 2",icon: Icon(Icons.smartphone)),BottomNavigationBarItem(label:"Screen 3",icon: Icon(Icons.smartphone)),BottomNavigationBarItem(label:"Screen 4",icon: Icon(Icons.smartphone))],
          type: BottomNavigationBarType.fixed,
          onTap: (ind){
            setState(() {
              this.ind = ind;
            });
          },
        ),
        body: screens[ind]
    );
  }
}


class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {

  Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: ()
            {
              auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => Toggle()));
            },
          )
        ],
      ),
      drawer: Drawer(),
    );
  }
}

