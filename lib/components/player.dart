import "dart:ui";

import 'package:raw_game/game_Controller.dart';
import 'package:raw_game/state.dart';

class Player {
  final GameController gameController;
  State state;
  int maxHealth;
  int currentHealth;
  Rect playerRect;
  bool isDead = false;

  Player(this.gameController) {
    maxHealth = currentHealth = 400;
    final size = gameController.tileSize * 1.5;
    playerRect = Rect.fromLTWH(
      gameController.screenSize.width / 2 - size / 2,
      gameController.screenSize.height / 2 - size / 2,
      size,
      size,
    );
  }
  void render(Canvas c) {
    Paint color = Paint()..color = Color(0xFF0000FF);
    c.drawRect(playerRect, color);

    // c.drawImage(image, p, paint)
  }

  void update(double) {
    // print(currentHealth);
    if (!isDead && currentHealth <= 0) {
      isDead = true;
      gameController.playHomeBGM();

      state = State.paused;
      gameController.initializer();
    }
  }
}
