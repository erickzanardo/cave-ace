import 'package:flame/position.dart';

import '../../game.dart';
import '../enemies/enemy.dart';
import './bullet.dart';

import 'dart:ui';

class SimpleEnemyBullet extends Bullet {

  static const SIZE = CaveAce.TILE_SIZE / 2;

  SimpleEnemyBullet() : super(
      spritePath: "enemy_rock_bullet.png",
      speed: Position(0, 200),
      size: SIZE,
      rollingSpeed: 20,
      bulletHitBox: Rect.fromLTWH(5, 5, SIZE - 5, SIZE - 5),
  );


  @override
  void onUpdate(double dt) {

    if (collidesWith(gameRef.player)) {
      isDestroyed = true;

      gameRef.player.takeHit();
    }

    if (toRect().top >= gameRef.size.height)
      isDestroyed = true;
  }
}
