import 'package:flame/position.dart';

import './bullet.dart';
import '../../game.dart';
import '../has_hitbox.dart';

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
    gameRef.listHitableByEnemy().forEach((e) {
          if (collidesWith(e)) {
            isDestroyed = true;
            e.takeHit();
          }
        });

    if (toRect().top >= gameRef.size.height)
      isDestroyed = true;
  }
}
