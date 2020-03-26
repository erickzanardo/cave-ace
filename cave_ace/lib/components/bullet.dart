import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/anchor.dart';

import '../game.dart';
import './has_hitbox.dart';
import './enemies/enemy.dart';

import 'dart:math' as math;
import 'dart:ui';

class Bullet extends SpriteComponent with HasHitbox, HasGameRef<CaveAce> {

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

    // TODO this can probably lead to perfomance problems as
    // this is a very naive implementation but it is ok for now
    gameRef.components
        .where((c) => c is Enemy).cast()
        .forEach((e) {
          if (collidesWith(e)) {
            isDestroyed = true;
            e.takeHit();
          }
        });

    if (toRect().bottom <= 0)
      isDestroyed = true;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (gameRef.debugMode()) {
      renderHitboxOutline(canvas);
    }
  }

  @override
  Rect hitBox() => const Rect.fromLTWH(5, 5, SIZE - 5, SIZE - 5);

  @override
  bool destroy() => isDestroyed;
}
