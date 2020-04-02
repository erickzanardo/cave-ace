import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

import './models/stage.dart';
import './components/player.dart';
import './components/stage_controller.dart';
import './components/health_indicator.dart';
import './components/background.dart';
import './components/has_hitbox.dart';
import './components/bullets/bullet.dart';

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
    add(Background());
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
    listFireOpeners().forEach((e) {
      e.beginFire();
    });
  }

  @override
  void onPanEnd(_) {
    listFireOpeners().forEach((e) {
      e.stopFire();
    });
  }

  @override
  void onPanCancel() {
    listFireOpeners().forEach((e) {
      e.stopFire();
    });
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    player?.move(details.delta.dx, details.delta.dy);
  }

  @override
  Color backgroundColor() => Color(0xFFe8d282);

  Iterable<HitableByEnemy> listHitableByEnemy() =>
    components
        .where((c) => c is HitableByEnemy).cast();

  Iterable<HitableByPlayer> listHitableByPlayer() =>
    components
        .where((c) => c is HitableByPlayer).cast();

  Iterable<CanOpenFire> listFireOpeners() =>
    components
        .where((c) => c is CanOpenFire).cast();

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
