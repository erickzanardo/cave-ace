import 'package:flame/position.dart';

import '../../game.dart';
import '../has_hitbox.dart';
import './bullet.dart';

import 'dart:ui';

class SimplePlayerBullet extends Bullet {

  static const SIZE = CaveAce.TILE_SIZE / 2;

  SimplePlayerBullet() : super(
      spritePath: "rock_bullet.png",
      speed: Position(0, -400),
      size: SIZE,
      rollingSpeed: 50,
      bulletHitBox: Rect.fromLTWH(5, 5, SIZE - 5, SIZE - 5),
  );


  @override
  void onUpdate(double dt) {
    // TODO this can probably lead to perfomance problems as
    // this is a very naive implementation but it is ok for now
    gameRef.components
        .where((c) => c is HitableByPlayer).cast()
        .forEach((e) {
          if (collidesWith(e)) {
            isDestroyed = true;
            e.takeHit();
          }
        });

    if (toRect().bottom <= 0)
      isDestroyed = true;
  }
}
