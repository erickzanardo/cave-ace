import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/animation.dart';
import 'package:flame/time.dart';

import 'dart:ui';

import '../game.dart';
import './bullets/simple_player_bullet.dart';

import './has_hitbox.dart';

class Player extends PositionComponent with HasGameRef<CaveAce>, HasHitbox {

  Animation dino;
  Timer _bulletCreator;
  int health;

  Player() {
    width = CaveAce.TILE_SIZE * 3;
    height = CaveAce.TILE_SIZE * 2;

    dino = Animation.sequenced("hector.png", 4, textureWidth: 48, textureHeight: 32)
        ..stepTime = 0.2;

    _bulletCreator = Timer(0.5, repeat: true, callback: _createBullet);

    health = 2;
  }

  void _createBullet() {
    gameRef.add(
        SimplePlayerBullet()
          ..x = x + (width / 2) - (SimplePlayerBullet.SIZE / 2)
          ..y = y - SimplePlayerBullet.SIZE
    );
  }

  @override
  void update(double dt) {
    _bulletCreator.update(dt);
    if (dino.loaded()) {
      dino.update(dt);
    }
  }

  @override
  void render(Canvas canvas) {
    if (dino.loaded()) {
      dino.getSprite().renderRect(canvas, toRect());
    }
  }

  void beginFire() {
    _bulletCreator.start();
  }

  void stopFire() {
    _bulletCreator.stop();
  }

  void move(double dx, double dy) {
    x += dx;
    y += dy;
  }

  @override
  Rect hitBox() => const Rect.fromLTWH(
      CaveAce.TILE_SIZE,
      0,
      CaveAce.TILE_SIZE,
      CaveAce.TILE_SIZE * 2,
  );

  void takeHit() {
    health --;

    if (health == 0) {
      // TODO game over
    }
  }
}
