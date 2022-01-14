import 'package:flutter/material.dart';

import '../game_Controller.dart';

class StartText {
  final GameController gameController;
  TextPainter painter;
  Offset position;
  StartText(this.gameController) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
    painter.paint(c, position);
  }

  void update(double t) {
    painter.text = TextSpan(
      text: 'Start',
      style: TextStyle(
        color: Colors.black,
        fontSize: 40.0,
        fontStyle: FontStyle.italic
      ),
    );

    painter.layout();

    position = Offset(
      (gameController.screenSize.width / 2) - (painter.width / 2),
      (gameController.screenSize.height * 0.75) - (painter.height / 2),
    );

    
  }

  void onTapdown(){
    
  }
}
