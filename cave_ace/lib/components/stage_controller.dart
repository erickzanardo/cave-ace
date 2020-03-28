import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';

import 'dart:ui';
import '../game.dart';
import '../models/stage.dart';
import './wave_mapper.dart';

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
    final enemies = createWaveFormation(wave);

    enemies.forEach((e) {
      gameRef.add(e);
    });
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

