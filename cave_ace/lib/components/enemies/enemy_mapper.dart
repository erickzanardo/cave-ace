import './bomb_ptero.dart';
import './shooting_ptero.dart';
import './enemy.dart';

Enemy mapEnemy(String enemy) {
  if (enemy == 'BOMB_PTERO') {
    return BombPtero();
  } else if (enemy == 'SHOOTING_PTERO') {
    return ShootingPtero();
  }

  throw 'Unknow enemy type: $enemy';
}
