import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';
import 'package:flame/position.dart';

import '../../game.dart';
import '../bullets/bullet.dart';
import '../bullets/simple_player_bullet.dart';

class TrunkGunPower extends SpriteComponent with HasGameRef<CaveAce>, CanOpenFire {
  Timer _bulletCreator;

  Position offset;

  TrunkGunPower(this.offset, bool startFiring): super.square(CaveAce.TILE_SIZE, "trunk_gun.png") {
    _bulletCreator = Timer(0.5, repeat: true, callback: _createBullet);

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
    x = gameRef.player.x + offset.x;
    y = gameRef.player.y + offset.y;
  }

  void beginFire() {
    _bulletCreator.start();
  }

  void stopFire() {
    _bulletCreator.stop();
  }
}
