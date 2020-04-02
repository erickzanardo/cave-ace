import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';
import 'package:flame/position.dart';

import 'dart:ui';

import '../../game.dart';
import '../bullets/bullet.dart';
import '../bullets/simple_player_bullet.dart';

class TrunkGunPower extends SpriteComponent with HasGameRef<CaveAce>, CanOpenFire {
  Timer _bulletCreator;
  Timer _duration;

  bool show = true;
  double blinkCount = 0;

  Position offset;

  TrunkGunPower(this.offset, bool startFiring): super.square(CaveAce.TILE_SIZE, "trunk_gun.png") {
    _bulletCreator = Timer(0.5, repeat: true, callback: _createBullet);

    _duration = Timer(15, repeat: false)
        ..start();

    if (startFiring)
      _bulletCreator.start();
  }

  void _createBullet() {
    gameRef.add(
        SimplePlayerBullet()
          ..x = x + (width / 2) - (SimplePlayerBullet.SIZE / 2)
          ..y = y - SimplePlayerBullet.SIZE
    );
  }

  @override
  void update(double dt) {
    _bulletCreator.update(dt);
    _duration.update(dt);

    final p = (_duration.progress * 100).floor();
    if (p  > 70) {
      blinkCount += dt;

      if (blinkCount > (p > 85 ? 0.1 : 0.2)) {
        _blink();
        blinkCount = 0;
      }
    }

    x = gameRef.player.x + offset.x;
    y = gameRef.player.y + offset.y;
  }

  void beginFire() {
    _bulletCreator.start();
  }

  void stopFire() {
    _bulletCreator.stop();
  }

  void _blink() {
    show = !show;
    overridePaint = Paint()..color = const Color(0xFFFFFFFF).withOpacity(show ? 1 : 0);
  }

  @override
  bool destroy() => _duration.isFinished() || gameRef.player.destroy();
}
