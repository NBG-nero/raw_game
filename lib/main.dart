import 'package:flame/game/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:raw_game/Splash_screen.dart';
import 'package:raw_game/game_Controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:raw_game/components/bgm.dart";

void main() async {
  // BGM.attachWidgetBindingListener();
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  SharedPreferences storage = await SharedPreferences.getInstance();
  GameController gameController = GameController(storage);
  runApp(gameController.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = gameController.onTapDown;

  Flame.audio.disableLog();

  Flame.audio.loadAll(<String>[
    'Pat.mp3',
    'Superiority.mp3',
    'Victory.mp3',
    'Virtual World.mp3',
  ]);

  flameUtil.addGestureRecognizer(tapper);
}

class Maingame extends StatefulWidget {
  @override
  _MaingameState createState() => _MaingameState();
}

class _MaingameState extends State<Maingame> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
