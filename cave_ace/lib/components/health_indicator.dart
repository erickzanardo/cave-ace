import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/text_config.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';

import 'dart:ui';

import '../game.dart';

class HealthIndicator extends Component with HasGameRef<CaveAce> {

  TextConfig _textConfig;

  List<Rect> _points;
  static const FONT_SIZE = CaveAce.TILE_SIZE * 0.6;

  Sprite _sprite = Sprite("ham.png");

  @override
  void onMount() {
    _createPoints();

    _textConfig = TextConfig(
        fontSize: FONT_SIZE,
        color: Color(0xFF3E3B65),
        fontFamily: "CubeCavern",
    );
  }

  Rect _createPoint(int i) {
    return  Rect.fromLTWH(i * CaveAce.TILE_SIZE + 2, 10 + FONT_SIZE, CaveAce.TILE_SIZE, CaveAce.TILE_SIZE);
  }

  @override
  void update(double dt) {
    if (_points.length != gameRef.player.health && gameRef.player.health >= 0) {
      _createPoints();
    }
  }

  void _createPoints() {
    _points = List.generate(gameRef.player.health, (index) {
      return _createPoint(index);
    });
  }

  @override
  void render(Canvas canvas) {
    _textConfig.render(
        canvas,
        "Health",
        Position(5, 5)
    );

    _points.forEach((r) {
      _sprite.renderRect(canvas, r);
    });
  }
}

