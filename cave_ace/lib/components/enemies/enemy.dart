import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';

import 'dart:ui';

import '../../game.dart';
import '../has_hitbox.dart';
import '../explosion.dart';
import '../effects/hit_effect.dart';

abstract class EnemyBehaviour {
  void update(double dt, Enemy enemy);

  bool renderFlipY() => false;
  bool renderFlipX() => false;
}

class SingleDirectionBehavior extends EnemyBehaviour {

  final Position velocity;

  SingleDirectionBehavior(this.velocity);

  @override
  void update(double dt, Enemy enemy) {
    enemy.x += velocity.x * dt;
    enemy.y += velocity.y * dt;
  }

  @override
  bool renderFlipX() => velocity.x < 0;

  @override
  bool renderFlipY() => velocity.y > 0;
}

abstract class Enemy extends AnimationComponent with HasGameRef<CaveAce>, HasHitbox, HitableByPlayer {
  EnemyBehaviour behaviour;
  int hitPoints;

  bool _isDestroyed = false;

  Rect _hitBox;

  HitEffect hitEffect;

  void Function() onDestroyed;

  Enemy({
    double width,
    double height,
    String imagePath,
    int frameCount,
    double textureWidth,
    double textureHeight,
    double stepTime,

    this.hitPoints = 1,
    this.behaviour,

    Rect hitBox,
  }): super.sequenced(
      width,
      height,
      imagePath,
      frameCount,
      textureWidth: textureWidth,
      textureHeight: textureHeight,
      stepTime: stepTime
  ) {
    renderFlipY = behaviour.renderFlipY();
    renderFlipX = behaviour.renderFlipX();

    _hitBox = hitBox ?? Rect.fromLTWH(0, 0, width, height);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (hitEffect != null) {
      hitEffect.update(dt);

      if (hitEffect.done)
        hitEffect = null;
    }

    if (behaviour != null)
      behaviour.update(dt, this);

    gameRef.listHitableByEnemy().forEach((e) {
      if (collidesWith(e)) {
        _destroy();
        e.takeHit();
      }
    });

    onUpdate(dt);
  }

  void onUpdate(double dt) {}

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (gameRef.debugMode()) {
      renderHitboxOutline(canvas);
    }
  }

  @override
  Rect hitBox() => _hitBox;

  @override
  void onDestroy() {
    onDestroyed?.call();
  }

  @override
  bool destroy() => _isDestroyed || y > gameRef.size.height;

  void _destroy() {
    gameRef.add(Explosion.normal(x, y));
    _isDestroyed = true;
  }

  void takeHit() {
    hitPoints--;

    if (hitPoints == 0) {
      _destroy();
    } else if (hitEffect == null) {
      hitEffect = HitEffect(this);
    }
  }
}

