import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';

import 'dart:ui';

import '../ptero_carrier.dart';
import '../explosion.dart';
import '../has_hitbox.dart';
import '../../game.dart';

import './pickup.dart';


class PickupContainer extends SpriteComponent with HasGameRef<CaveAce>, HasHitbox, HitableByPlayer {

  static const double SPEED = 100;
  static const SIZE = CaveAce.TILE_SIZE * 2;

  String pickup;

  PteroCarrier _left;
  PteroCarrier _right;

  bool _isDestroyed = false;

  PickupContainer(this.pickup): super.square(SIZE, "box.png");

  @override
  void onMount() {
    width = SIZE;
    height = SIZE;

    final xDistance = width / 4;
    final yDistance = height * 0.8;

    gameRef.add(
        _left = PteroCarrier(
            following: this,
            followingDistance: Position(- width / 3, - height / 4),
            facingDown: true,
        )
    );

    gameRef.add(
        _right = PteroCarrier(
            following: this,
            followingDistance: Position(width - width / 3, - height / 4),
            facingDown: true,
        )
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
    _isDestroyed = true;

    PositionComponent comp;
    if (pickup == "SHIELD") {
      comp = ShieldPickup();
    } else if (pickup == "TRUNK_GUN") {
      comp = TrunkGunPickup();
    }

    gameRef.add(
        comp
        ..x = x
        ..y = y
    );
  }

  @override
  bool destroy() {
    final destroy = _isDestroyed || y >= gameRef.size.height;

    if (destroy) {
      _left.vanish(-1);
      _right.vanish(1);
    }

    return destroy;
  }
}
