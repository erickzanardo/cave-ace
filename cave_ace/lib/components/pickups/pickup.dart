import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';

import 'dart:ui';
import 'dart:math';
import '../../game.dart';
import '../has_hitbox.dart';

abstract class Pickup extends SpriteComponent with HasGameRef<CaveAce>, HasHitbox {
  static const SPEED = 30;

  bool _isDestroyed = false;
  Rect _hitBox;
  Position _speed;

  Random random = Random();

  String pickupName;

  Pickup({
      this.pickupName,

      double width,
      double height,
      String image,
      Rect hitBox,
  }): super.rectangle(width, height, image) {
    _hitBox = hitBox ?? Rect.fromLTWH(0, 0, width, height);

    _speed = Position(
        random.nextBool() ? 1 : -1,
        1
    );
  }

  @override
  void update(double dt) {
    x += _speed.x * SPEED * dt;
    y += _speed.y * SPEED * dt;

    final r = toRect();
    if (r.right >= gameRef.size.width || r.left <= 0) {
      _speed.x = _speed.x * -1;
    }

    if (r.bottom >= gameRef.size.height || r.top <= 0) {
      _speed.y = _speed.y * -1;
    }

    if (collidesWith(gameRef.player)) {
      _isDestroyed = true;

      gameRef.player.collectPickup(pickupName);
    }
  }

  @override
  Rect hitBox() => _hitBox;

  @override
  bool destroy() => _isDestroyed;
}

class ShieldPickup extends Pickup {
  ShieldPickup(): super(
      pickupName: "SHIELD",
      width: CaveAce.TILE_SIZE,
      height: CaveAce.TILE_SIZE,
      image: "shield.png",
  );
}

class TrunkGunPickup extends Pickup {
  TrunkGunPickup(): super(
      pickupName: "TRUNK_GUN",
      width: CaveAce.TILE_SIZE,
      height: CaveAce.TILE_SIZE,
      image: "trunk_pickup.png",
  );
}

class HealthPickup extends Pickup {
  HealthPickup(): super(
      pickupName: "HEALTH",
      width: CaveAce.TILE_SIZE,
      height: CaveAce.TILE_SIZE,
      image: "ham.png",
  );
}
