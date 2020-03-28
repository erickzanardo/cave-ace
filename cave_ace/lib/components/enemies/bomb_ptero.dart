import 'package:flame/position.dart';
import 'dart:ui';

import '../../game.dart';
import './enemy.dart';

class BombPtero extends Enemy {
  static const SPEED = 50.0;

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
      ),

      hitBox: Rect.fromLTWH(
          CaveAce.TILE_SIZE,
          0,
          CaveAce.TILE_SIZE,
          CaveAce.TILE_SIZE * 2,
      ),
  );
}
