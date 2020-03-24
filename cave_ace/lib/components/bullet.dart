import 'package:flame/components/component.dart';
import 'package:flame/anchor.dart';

import '../game.dart';

import 'dart:math' as math;

class Bullet extends SpriteComponent {

  static const SPEED = 400;
  static const SIZE = CaveAce.TILE_SIZE / 2;
  static const ROLLING_SPEED = 50.0;


  Bullet() : super.square(SIZE, "rock_bullet.png") {
    anchor = Anchor.center;
  }

  bool isDestroyed = false;

  double get radius => math.sqrt(width * width + height * height) / 2;
  double get angularSpeed => ROLLING_SPEED / radius;

  @override
  void update(double dt) {
    angle += dt * angularSpeed;
    y -= SPEED * dt;

    if (toRect().bottom <= 0)
      isDestroyed = true;
  }

  @override
  bool destroy() => isDestroyed;
}
