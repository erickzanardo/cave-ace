import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/anchor.dart';
import 'package:flame/position.dart';

import '../../game.dart';
import '../has_hitbox.dart';

import 'dart:math' as math;
import 'dart:ui';


mixin CanOpenFire {
  void beginFire();
  void stopFire();
}

abstract class Bullet extends SpriteComponent with HasHitbox, HasGameRef<CaveAce> {

  final Position speed;
  final double size;
  final double rollingSpeed;
  final Rect bulletHitBox;

  Bullet({
    String spritePath,
    this.speed,
    this.size,
    this.rollingSpeed,
    this.bulletHitBox,
  }) : super.square(size, spritePath) {
    anchor = Anchor.center;
  }

  bool isDestroyed = false;

  double get radius => math.sqrt(width * width + height * height) / 2;
  double get angularSpeed => rollingSpeed / radius;

  @override
  void update(double dt) {
    angle += dt * angularSpeed;
    y += speed.y * dt;
    x += speed.x * dt;

    onUpdate(dt);

    if (toRect().bottom <= 0)
      isDestroyed = true;
  }

  void onUpdate(double dt);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (gameRef.debugMode()) {
      renderHitboxOutline(canvas);
    }
  }

  @override
  Rect hitBox() => bulletHitBox;

  @override
  bool destroy() => isDestroyed;
}

