import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';

import 'dart:ui';
import '../game.dart';
import '../models/stage.dart';
import './wave_mapper.dart';
import '../components/pickup_container.dart';

class StageController extends Component with HasGameRef<CaveAce> {

  final Stage stage;
  List<Timer> _timers = [];

  StageController(this.stage) {
    _timers.addAll(stage.waves.map((wave) =>
      Timer(wave.time.toDouble(), repeat: false, callback: () {
        _handleWave(wave);
      })
      // Probably remove this after we add a nice stage init animation
      ..start()
    ).toList());

    _timers.addAll(stage.pickups.map((pickup) =>
      Timer(pickup.time.toDouble(), repeat: false, callback: () {
        _handlePickup(pickup);
      })
      // Probably remove this after we add a nice stage init animation
      ..start()
    ).toList());
  }

  void _handleWave(Wave wave) {
    final enemies = createWaveFormation(wave);

    enemies.forEach((e) {
      gameRef.add(e);
    });
  }

  void _handlePickup(Pickup pickup) {
    final pickupContainer = PickupContainer(pickup.pickup);

    pickupContainer.x = pickup.x * CaveAce.TILE_SIZE;
    pickupContainer.y = -pickupContainer.height;

    gameRef.add(pickupContainer);
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

