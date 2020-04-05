import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';
import 'package:flame/position.dart';

import 'dart:ui';

import '../game.dart';
import './bullets/bullet.dart';
import './bullets/simple_player_bullet.dart';
import './explosion.dart';
import './has_hitbox.dart';
import './powers/shield.dart';
import './powers/trunk_gun.dart';
import './effects/hit_effect.dart';

class Player extends AnimationComponent with HasGameRef<CaveAce>, HasHitbox, HitableByEnemy, CanOpenFire {

  Timer _bulletCreator;
  int health;
  HitEffect hitEffect;

  bool _isDestroyed = false;

  Player(): super.sequenced(
      CaveAce.TILE_SIZE * 3,
      CaveAce.TILE_SIZE * 2,
      "hector.png",
      4,
      textureWidth: 48,
      textureHeight: 32,
      stepTime: 0.2,
  ) {

    _bulletCreator = Timer(0.5, repeat: true, callback: _createBullet);

    health = 2;
  }

  void _createBullet() {
    gameRef.add(
        SimplePlayerBullet()
          ..x = x + (width / 2) - (SimplePlayerBullet.SIZE / 2)
          ..y = y - SimplePlayerBullet.SIZE
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    _bulletCreator.update(dt);

    if (hitEffect != null) {
      hitEffect.update(dt);

      if (hitEffect.done)
        hitEffect = null;
    }
  }

  void beginFire() {
    _bulletCreator.start();
  }

  void stopFire() {
    _bulletCreator.stop();
  }

  void move(double dx, double dy) {
    x += dx;
    y += dy;
  }

  @override
  Rect hitBox() => const Rect.fromLTWH(
      CaveAce.TILE_SIZE,
      0,
      CaveAce.TILE_SIZE,
      CaveAce.TILE_SIZE * 2,
  );

  void takeHit() {
    health --;

    if (health == 0) {
      _isDestroyed = true;
      gameRef.add(
          Explosion.big(x, y)
          ..onFinish = _callGameOver
      );
    } else if (hitEffect == null) {
      hitEffect = HitEffect(this);
    }
  }

  void _callGameOver() {
    gameRef.gameOver();
  }

  @override
  bool destroy() => _isDestroyed;

  void collectPickup(String pickupName) {
    if (pickupName == "SHIELD") {
      gameRef.add(ShieldPower());
    } else if (pickupName == "HEALTH") {
      health++;
    } else if (pickupName == "TRUNK_GUN") {
      gameRef.add(
          TrunkGunPower(
              Position(
                  -(CaveAce.TILE_SIZE + CaveAce.TILE_SIZE / 2),
                  CaveAce.TILE_SIZE
              ),
              _bulletCreator.isRunning(),
          )
      );

      gameRef.add(
          TrunkGunPower(
              Position(
                  width + CaveAce.TILE_SIZE / 2,
                  CaveAce.TILE_SIZE
              ),
              _bulletCreator.isRunning(),
          )
      );
    }
  }
}
