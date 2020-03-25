import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';

import 'dart:ui';
import '../game.dart';
import '../models/stage.dart';
import './enemies/bomb_ptero.dart';

class StageController extends Component with HasGameRef<CaveAce> {

  final Stage stage;
  List<Timer> _timers = [];

  StageController(this.stage) {
    _timers = stage.waves.map((wave) =>
      Timer(wave.time.toDouble(), repeat: false, callback: () {
        _handleWave(wave);
      })
      // Probably remove this after we add a nice stage init animation
      ..start()
    ).toList();
  }

  void _handleWave(Wave wave) {
    final enemies = _createWaveFormation(wave);

    enemies.forEach((e) {
      gameRef.add(e);
    });
  }

  List<PositionComponent> _createWaveFormation(Wave wave) {

    List<PositionComponent> result = [];
    if (wave.formation == 'LINE') {
      for (var i = 0; i < wave.units; i++) {
        result.add(
            _mapEnemy(wave.enemy)
            ..x = (wave.x * CaveAce.TILE_SIZE) + (i * wave.unitSize * CaveAce.TILE_SIZE).toDouble()
        );
      }

      return result;
    }
    
    throw 'Unknow formation type: ${wave.formation}';
  }

  // TODO move this away and make it consider other type of enemies
  PositionComponent _mapEnemy(String enemy) {
    if (enemy == 'BOMB_PTERO') {
      return BombPtero();
    }

    throw 'Unknow enemy type: $enemy';
  }

  @override
  void update(double dt) {
    _timers.forEach((timer) {
      timer.update(dt);
    });
  }

  @override
  void render(Canvas canvas) {
  }
}

