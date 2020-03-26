import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';

import '../../game.dart';

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

abstract class Enemy extends AnimationComponent with HasGameRef<CaveAce> {
  EnemyBehaviour behaviour;

  Enemy({
    double width,
    double height,
    String imagePath,
    int frameCount,
    double textureWidth,
    double textureHeight,
    double stepTime,

    this.behaviour,
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
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (behaviour != null)
      behaviour.update(dt, this);
  }

  @override
  bool destroy() => y > gameRef.size.height;
}

