import 'package:flame/components/component.dart';
import './enemies/enemy_mapper.dart';
import '../models/stage.dart';
import '../game.dart';

List<PositionComponent> createWaveFormation(Wave wave) {

  List<PositionComponent> result = [];
  if (wave.formation == 'LINE') {
    for (var i = 0; i < wave.units; i++) {
      result.add(
          mapEnemy(wave.enemy)
          ..x = (wave.x * CaveAce.TILE_SIZE) + (i * wave.unitSize * CaveAce.TILE_SIZE).toDouble()
      );
    }

    return result;
  } else if (wave.formation == 'COLUMN') {
    for (var i = 0; i < wave.units; i++) {
      result.add(
          mapEnemy(wave.enemy)
          ..y =  -(i * wave.unitSize * CaveAce.TILE_SIZE).toDouble()
          ..x = (wave.x * CaveAce.TILE_SIZE)
      );
    }

    return result;
  }

  throw 'Unknow formation type: ${wave.formation}';
}

