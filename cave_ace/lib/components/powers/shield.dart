import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

import 'dart:ui';
import 'dart:math';

import '../../game.dart';
import '../has_hitbox.dart';

import '../explosion.dart';

class ShieldPower extends SpriteComponent with HasGameRef<CaveAce>, HasHitbox, HitableByEnemy {
  static const SPEED = 200;
  static const DISTANCE = 50;

  ShieldPower(): super.square(CaveAce.TILE_SIZE, "shield.png");

  double orbitAngle = 0.0;

  bool _isDestroyed = false;

  @override
  void update(double dt) {
    orbitAngle += SPEED * dt;

    if (orbitAngle > 360) angle = 0;

    final radian = orbitAngle * pi / 180;

    final playerCenter = gameRef.player.toRect().center;
    x = (playerCenter.dx) + (DISTANCE * cos(radian)) - CaveAce.TILE_SIZE / 2;
    y = (playerCenter.dy) + (DISTANCE * sin(radian)) - CaveAce.TILE_SIZE / 2;
  }

  @override
  Rect hitBox() => Rect.fromLTWH(0, 0, width, height);

  @override
  void takeHit() {
    _isDestroyed = true;
    gameRef.add(Explosion.small(x, y));
  }

  @override
  bool destroy() => _isDestroyed;
}


