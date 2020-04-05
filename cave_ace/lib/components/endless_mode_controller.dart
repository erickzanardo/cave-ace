import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/text_config.dart';
import 'package:flame/time.dart';

import 'dart:math';
import 'dart:ui';
import '../game.dart';
import '../components/pickups/pickup_container.dart';

import '../components/enemies/enemy.dart';
import '../components/enemies/bomb_ptero.dart';
import '../components/enemies/shooting_ptero.dart';


class WaveTextComponent extends TextComponent with HasGameRef<CaveAce> {
  static const FONT_SIZE = CaveAce.TILE_SIZE * 1.2;

  Timer _timer;

  WaveTextComponent(String text): super(
      text,
      config: TextConfig(
          fontSize: FONT_SIZE,
          color: Color(0xFF3E3B65),
          fontFamily: "CubeCavern",
      )
  );

  @override
  void onMount() {
    _timer = Timer(2, repeat: false)..start();

    x = gameRef.size.width / 2 - width / 2;
    y = gameRef.size.height / 2 - height / 2;
  }

  @override
  void update(double dt) {
    _timer?.update(dt);
  }

  @override
  bool destroy() => _timer?.isFinished();
}

class EndlessModeController extends Component with HasGameRef<CaveAce> {
  static const FONT_SIZE = CaveAce.TILE_SIZE * 0.6;

  TextConfig _textConfig;

  int wave = 1;
  int enemyCount;

  Random random = Random();
  Timer waveDelay;

  EndlessModeController() {
    _textConfig = TextConfig(
        fontSize: FONT_SIZE,
        color: Color(0xFF3E3B65),
        fontFamily: "CubeCavern",
    );
  }

  @override
  void onMount() {
    _startWave();
  }

  @override
  void update(double dt) {
    waveDelay?.update(dt);
  }

  String _createRandomPickup() {
    final chance = random.nextDouble();

    if (chance <= 0.33) {
      return "HEALTH";
    } else if (chance <= 0.66) {
      return "TRUNK_GUN";
    }
    return "SHIELD";
  }

  void _startNextWave() {
    if (gameRef.player.health == 0)
      return;

    wave++;

    final pickupContainer = PickupContainer(_createRandomPickup());
    pickupContainer.x = gameRef.size.width / 2 - pickupContainer.width / 2;
    pickupContainer.y = -pickupContainer.height;
    gameRef.addLater(pickupContainer);

    waveDelay = Timer(4, callback: () {
      _startWave();
    })..start();
  }

  void _startWave() {
    enemyCount = wave * 5;

    gameRef.add(WaveTextComponent("Wave $wave"));

    for (var i = 0; i < enemyCount; i += 1) {
      final enemy = _createEnemy();

      enemy.x = (gameRef.size.width - enemy.width) * random.nextDouble();
      enemy.y = -(i * 100).toDouble();

      enemy.onDestroyed = () {
        enemyCount--;

        if (enemyCount == 0) {
          gameRef.add(WaveTextComponent("Wave complete!"));
          _startNextWave();
        }
      };

      gameRef.addLater(enemy);
    }
  }

  Enemy _createEnemy() {
    if (random.nextBool()) {
      return BombPtero();
    } else {
      return ShootingPtero();
    }
  }

  @override
  void render(Canvas canvas) {
    final label = "Wave: $wave";
    _textConfig.render(
        canvas,
        label,
        Position(gameRef.size.width - 75 , 5)
    );
  }
}
