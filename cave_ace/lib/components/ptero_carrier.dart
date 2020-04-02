import 'package:flame/components/component.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';

import '../game.dart';

class PteroCarrier extends AnimationComponent with HasGameRef<CaveAce> {

  static const double VANISHING_SPEED = 350;

  static const PTERO_WIDTH = CaveAce.TILE_SIZE * 3 * 0.4;
  static const PTERO_HEIGHT = CaveAce.TILE_SIZE * 2 * 0.4;

  Position speed;

  PositionComponent following;
  Position followingDistance;

  bool facingDown;

  PteroCarrier({
    String imagePath = "hector_no_mount.png",
    this.speed,
    this.following,
    this.followingDistance,

    this.facingDown,
  }): super.sequenced(
      PTERO_WIDTH,
      PTERO_HEIGHT,
      imagePath,
      4,
      textureWidth: 48,
      textureHeight: 32,
      stepTime: 0.2,
  ) {
    renderFlipY = facingDown;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (following != null && followingDistance != null) {
      x = following.x + followingDistance.x;
      y = following.y + followingDistance.y;
    } else {
      y += speed.y * dt;
      x += speed.x * dt;
    }
  }

  void vanish(int dir) {
    speed = Position(
        VANISHING_SPEED / 2 * dir,
        VANISHING_SPEED,
    );

    followingDistance = null;
    following = null;
  }

  @override
  bool destroy() => y > gameRef.size.height || x > gameRef.size.width || toRect().right < 0;
}
