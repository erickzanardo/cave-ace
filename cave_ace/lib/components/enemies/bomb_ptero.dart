import 'package:flame/position.dart';

import '../../game.dart';
import './enemy.dart';

class BombPtero extends Enemy {
  static const SPEED = 30.0;

  BombPtero(): super(
      width: CaveAce.TILE_SIZE * 3,
      height: CaveAce.TILE_SIZE * 2,
      imagePath: 'bomb_ptero.png',
      frameCount: 4,
      textureWidth: 48,
      textureHeight: 32,
      stepTime: 0.2,

      behaviour: SingleDirectionBehavior(
          Position(0.0, SPEED)
      )
  );
}
