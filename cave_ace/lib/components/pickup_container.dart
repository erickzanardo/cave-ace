import 'package:flame/components/component.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

import 'dart:ui';

import './explosion.dart';
import './has_hitbox.dart';
import '../game.dart';

class _PteroCarrier extends AnimationComponent with HasGameRef<CaveAce> {

  static const double VANISHING_SPEED = 350;

  static const PTERO_WIDTH = CaveAce.TILE_SIZE * 3 * 0.4;
  static const PTERO_HEIGHT = CaveAce.TILE_SIZE * 2 * 0.4;

  double _xSpeed = 0;
  double _ySpeed = PickupContainer.SPEED;

  _PteroCarrier(): super.sequenced(
      PTERO_WIDTH,
      PTERO_HEIGHT,
      "hector_no_mount_inverted.png",
      4,
      textureWidth: 48,
      textureHeight: 32,
      stepTime: 0.2,
  );

  @override
  void update(double dt) {
    super.update(dt);

    y += _ySpeed * dt;
    x += _xSpeed * dt;
  }

  void vanish(int dir) {
    _ySpeed = VANISHING_SPEED;
    _xSpeed = VANISHING_SPEED / 2 * dir;
  }

  @override
  bool destroy() => y > gameRef.size.height || x > gameRef.size.width || toRect().right < 0;
}

class PickupContainer extends SpriteComponent with HasGameRef<CaveAce>, HasHitbox, HitableByPlayer {

  static const double SPEED = 100;
  static const SIZE = CaveAce.TILE_SIZE * 2;

  String pickup;

  _PteroCarrier _left;
  _PteroCarrier _right;

  bool _isDestroyed = false;

  PickupContainer(this.pickup): super.square(SIZE, "box.png");

  @override
  void onMount() {
    width = SIZE;
    height = SIZE;

    gameRef.add(
        _left = _PteroCarrier()
        ..x = x - width / 3
        ..y = y - height / 4
    );

    gameRef.add(
        _right = _PteroCarrier()
        ..x = toRect().right - width / 3
        ..y = y - height / 4
    );
  }

  @override
  void update(double dt) {

    final travelAmmount = SPEED * dt;
    y += travelAmmount;
  }

  @override
  Rect hitBox() => const Rect.fromLTWH(10, 10, SIZE - 10, SIZE - 10);

  @override
  void takeHit() {
    gameRef.add(Explosion.small(x, y));
    _left.vanish(-1);
    _right.vanish(1);
    _isDestroyed = true;
    // TODO spawn pickup
  }

  @override
  bool destroy() => _isDestroyed || y >= gameRef.size.height;
}
