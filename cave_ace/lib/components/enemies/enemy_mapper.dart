import './bomb_ptero.dart';
import './enemy.dart';

Enemy mapEnemy(String enemy) {
  if (enemy == 'BOMB_PTERO') {
    return BombPtero();
  }

  throw 'Unknow enemy type: $enemy';
}
