import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

import './models/stage.dart';
import './components/player.dart';
import './components/stage_controller.dart';
import './components/health_indicator.dart';

import './widgets/game_over.dart';

class CaveAce extends BaseGame with PanDetector, HasWidgetsOverlay {

  static const double TILE_SIZE = 30.0;
  Player player;
  Stage stage;

  @override
  bool debugMode() => false;

  CaveAce(this.stage, Size _size) {
    this.size = _size;

    _init();
  }

  void _init() {
    add(StageController(stage));

    player = Player();
    player.x = (size.width / 2) - (player.width / 2);
    player.y = size.height - player.height - 50;

    add(player);

    add(HealthIndicator());
  }

  void _restart() {
    components.clear();
    _init();
  }

  @override
  void onPanStart(_) {
    player?.beginFire();
  }

  @override
  void onPanEnd(_) {
    player?.stopFire();
  }

  @override
  void onPanCancel() {
    player?.stopFire();
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    player?.move(details.delta.dx, details.delta.dy);
  }

  @override
  Color backgroundColor() => Color(0xFF36c5f4);

  void gameOver() {
    addWidgetOverlay(
        "GameOver",
        GameOverOverlay(
            width: TILE_SIZE * 10,
            height: TILE_SIZE * 10,

            onRestart: () {
              removeWidgetOverlay("GameOver");
              _restart();
            }
        )
    );
  }
}
