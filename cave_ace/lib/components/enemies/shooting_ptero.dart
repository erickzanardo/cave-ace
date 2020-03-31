import 'package:flame/position.dart';
import 'package:flame/time.dart';

import 'dart:ui';
import 'dart:math';

import '../bullets/simple_enemy_bullet.dart';
import '../../game.dart';
import './enemy.dart';

class ShootingPtero extends Enemy {
  static const SPEED = 50.0;
  
  final _random = Random();
  Timer _shooter;

  ShootingPtero(): super(
      width: CaveAce.TILE_SIZE * 3,
      height: CaveAce.TILE_SIZE * 2,
      imagePath: 'shooting_ptero.png',
      frameCount: 4,
      textureWidth: 48,
      textureHeight: 32,
      stepTime: 0.2,

      hitPoints: 2,

      behaviour: SingleDirectionBehavior(
          Position(0.0, SPEED)
      ),

      hitBox: Rect.fromLTWH(
          CaveAce.TILE_SIZE,
          0,
          CaveAce.TILE_SIZE,
          CaveAce.TILE_SIZE * 2,
      ),
  ) {
    _shooter =  Timer(2, repeat: true, callback: _shoot);
    _shooter.start();
  }


  void _shoot() {
    if (_random.nextDouble() >= 0.3) {
      gameRef.add(
          SimpleEnemyBullet()
          ..x = x + (width / 2)
          ..y = y + height
      );
    }
  }

  onUpdate(double dt) {
    _shooter.update(dt);
  }
}
