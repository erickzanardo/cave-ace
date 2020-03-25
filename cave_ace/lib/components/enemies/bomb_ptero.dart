import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

import '../../game.dart';

class BombPtero extends AnimationComponent with HasGameRef<CaveAce> {
  static const SPEED = 30;

  BombPtero(): super.sequenced(
      CaveAce.TILE_SIZE * 3,
      CaveAce.TILE_SIZE * 2,
      'bomb_ptero.png',
      4,
      textureWidth: 48,
      textureHeight: 32,
      stepTime: 0.2
  ) {
    renderFlipY = true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    y += SPEED * dt;
  }

  @override
  bool destroy() => y > gameRef.size.height;
}
