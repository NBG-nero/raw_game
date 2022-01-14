import 'dart:async';
import 'dart:math';
import 'dart:ui';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart' show rootBundle;

import 'package:audioplayers/audio_cache.dart';
import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flutter/gestures.dart';
// import 'package:raw_game/Splash_screen.dart';
import 'package:raw_game/components/enemy.dart';
import 'package:raw_game/components/enemy_spawner.dart';
import 'package:raw_game/components/health_bar.dart';
import 'package:raw_game/components/highscoretext.dart';
import 'package:raw_game/components/player.dart';
import 'package:raw_game/components/score_text.dart';
import 'package:raw_game/components/start_text.dart';
import 'package:raw_game/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class GameController extends Game {
  final SharedPreferences storage;

  Random rand;
  Size screenSize;
  double tileSize;
  Player player;
  EnemySpawner enemySpawner;
  List<Enemy> enemies;
  HealthBar healthBar;
  int score;
  ScoreText scoreText;
  State state;
  HighscoreText highscoreText;
  StartText startText;
  // ui.Image image;
  bool isImageloaded = false;
  AudioPlayer homeBGM;
  AudioPlayer playingBGM;
  

  GameController(this.storage) {
    initializer();
  }
  void initializer() async {
    resize(await Flame.util.initialDimensions());
    state = State.menu;
    rand = Random();
    player = Player(this);
    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);
    healthBar = HealthBar(this);
    score = 0;
    scoreText = ScoreText(this);
    highscoreText = HighscoreText(this);
    startText = StartText(this);
    homeBGM =
        await Flame.audio.loopLongAudio('Superiority' + '.mp3', volume: .24);
    homeBGM.pause();

    playingBGM =
        await Flame.audio.loopLongAudio('Virtual World' + '.mp3', volume: .24);
    playingBGM.pause();

    playHomeBGM();
    // spawnEnemy();
  }

  

  // Future<Null> initalizer() async {
  //   final ByteData data = await rootBundle.load("assets/images/bgi.jpg");
  //   image = await loadImage(new Uint8List.view(data.buffer));
  // }

  // Future<ui.Image> loadImage(List<int> img) async {
  //   final Completer<ui.Image> completer = new Completer();
  //   ui.decodeImageFromList(img, (ui.Image img) {
  //     setState((

  //     ){
  //       isImageloaded = true;
  //     });
  //   })
  // }

  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);

    Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);

    c.drawRect(background, backgroundPaint);

    if (score >= 20) {
      Paint backgroundPaint = Paint()..color = Color(0xFFEEEEEE);
      c.drawRect(background, backgroundPaint);
    }
    if (score >= 40) {
      Paint backgroundPaint = Paint()..color = Color(0xFFE0E0E0);
      c.drawRect(background, backgroundPaint);
    }
    if (score >= 60) {
      Paint backgroundPaint = Paint()..color = Color(0xFFD6D6D6);
      c.drawRect(background, backgroundPaint);
    }
    if (score >= 80) {
      Paint backgroundPaint = Paint()..color = Color(0xFFBDBDBD);
      c.drawRect(background, backgroundPaint);
    }
    if (score >= 100) {
      Paint backgroundPaint = Paint()..color = Color(0xFF9E9E9E);
      c.drawRect(background, backgroundPaint);
    }
    if (score >= 120) {
      Paint backgroundPaint = Paint()..color = Color(0xFF757575);
      c.drawRect(background, backgroundPaint);
    }
    if (score >= 140) {
      Paint backgroundPaint = Paint()..color = Color(0xFF616161);
      c.drawRect(background, backgroundPaint);
    }
    if (score >= 160) {
      Paint backgroundPaint = Paint()..color = Color(0xFF424242);
      c.drawRect(background, backgroundPaint);
    }

    player.render(c);
    if (state == State.menu) {
      startText.render(c);

      highscoreText.render(c);
    } else if (state == State.playing) {
      enemies.forEach((Enemy enemy) => enemy.render(c));
      scoreText.render(c);
      healthBar.render(c);
    }
  }

  void update(double t) {
    if (state == State.menu) {
      startText.update(t);
      highscoreText.update(t);
    } else if (state == State.playing) {
      enemySpawner.update(t);
      enemies.forEach((Enemy enemy) => enemy.update(t));
      enemies.removeWhere((Enemy enemy) => enemy.isDead);
      player.update(t);
      scoreText.update(t);
      healthBar.update(t);
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }

  void onTapDown(TapDownDetails d) {
    // print(d.globalPosition);
    if (state == State.menu) {
      // playHomeBGM();
      playPlayingBGM();
      // homeBGM.pause();

      state = State.playing;
    } else if (state == State.playing) {
      //  Flame.audio.play('Superiority' +  '.mp3' );

      enemies.forEach((Enemy enemy) {
        if (enemy.enemyRect.contains(d.globalPosition)) {
          enemy.onTapDown();
          // startText.onTapDown();
        }
      });
    }
  }

  void playHomeBGM() {
    playingBGM.pause();
    playingBGM.seek(Duration.zero);
    homeBGM.resume();
  }

  void playPlayingBGM() {
    homeBGM.pause();
    homeBGM.seek(Duration.zero);
    playingBGM.resume();
  }

  void spawnEnemy() {
    double x, y;
    switch (rand.nextInt(4)) {
      case 0:
        //top
        x = rand.nextDouble() * screenSize.width;
        y = -tileSize * 2.5;
        break;
      case 1:
        //right
        x = screenSize.width + tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
      case 2:
        //bottom
        x = rand.nextDouble() * screenSize.width;
        y = screenSize.height + tileSize * 2.5;
        break;
      case 3:
        //left
        x = -tileSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
    }
    enemies.add(Enemy(this, x, y));
  }
}
