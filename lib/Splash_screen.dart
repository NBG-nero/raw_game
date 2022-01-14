import 'dart:async';
// import 'dart:html';
// import 'package:raw_game/state.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:raw_game/game_Controller.dart';
// import 'package:raw_game/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  SharedPreferences storage;
  State state;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) {
            // if (me=1) {return Scaffold();};
        GameController(storage);
      }), (Route route) => route == null);
    });
  }
  //  Navigator.push(context,
  // MaterialPageRoute(builder: (BuildContext context) {
  // GameController(storage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: Color(0xff622F74),
          gradient: LinearGradient(
            colors: [Color(0xff29dfb7), Color(0xff3ec7fd)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 62.5,
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: _animation.value * 100.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Text(
                    "REALTOR",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Text("Home is where it's at",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold)),
                ],
              ))
        ],
      )
    ]));
  }
}
// class Splashscreen extends StatefulWidget {
//   @override
//   _SplashscreenState createState() => _SplashscreenState();
// }

// class _SplashscreenState extends State<Splashscreen> {
//   FlameSplashController controller;
//     SharedPreferences storage;
//   @override
//   void initState() {
//     super.initState();
//     controller = FlameSplashController(
//         fadeInDuration: Duration(seconds: 1),
//         fadeOutDuration: Duration(milliseconds: 250),
//         waitDuration: Duration(seconds: 2),
//         autoStart: false);
//   }

//   @override
//   void dispose() {
//     controller.dispose(); // dispose it when necessary
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FlameSplashScreen(
//           showBefore: (BuildContext context) {
//             return Text("Before the logo");
//           },
//           showAfter: (BuildContext context) {
//             return Text("After the logo");
//           },
//           theme: FlameSplashTheme.white,
//           onFinish: (context) =>
//               //  Navigator.of(context).pushAndRemoveUntil(
//               //  MaterialPageRoute(builder: (BuildContext context) => GameController(),
//               //  (Route route) => route == null),
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (BuildContext context) {
//                 GameController(storage);
//               }))
//           // controller: controller,
//           ),
//     );
//   }
// }
