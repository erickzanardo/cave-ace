import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart';

import '../game.dart';

class Explosion extends AnimationComponent {

  Explosion.small(double x, double y): this(x, y, CaveAce.TILE_SIZE / 2, CaveAce.TILE_SIZE / 2);
  Explosion.normal(double x, double y): this(x, y, CaveAce.TILE_SIZE, CaveAce.TILE_SIZE);
  Explosion.big(double x, double y): this(x, y, CaveAce.TILE_SIZE * 2, CaveAce.TILE_SIZE * 2);

  Explosion(double x, double y, double width, double height): super(
      50,
      50,
      Animation.sequenced("explosion.png", 6, textureWidth: 32, textureHeight: 32, stepTime: 0.05),
      destroyOnFinish: true
  ) {
      this.x = x;
      this.y = y;
    }
}
