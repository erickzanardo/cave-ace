import 'package:flame/sprite.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

import 'dart:ui';
import 'dart:math';

import '../game.dart';

class _Section {
  Sprite sprite;
  Rect pos;
}

class Background extends Component with HasGameRef<CaveAce> {

  static const ORIGINAL_SECTION_WIDTH = 160;
  static const ORIGINAL_SECTION_HEIGHT = 80;

  static const SPEED = 20;

  double _sectionW;
  double _sectionH;

  List<Sprite> _templates = [];
  List<_Section> _sections = [];

  Random random = Random();

  @override
  void update(double dt) {
    _sections.forEach((s) {
      s.pos = s.pos.translate(0, SPEED * dt);
    });

    if (_sections.last.pos.top >= gameRef.size.height) {
      _sections.removeLast();

      final y = _sections.first.pos.top - _sectionH;
      _sections.insert(0, _newSection(y));
    }
  }

  @override
  void render(Canvas canvas) {
    _sections.forEach((s) {
      s.sprite.renderRect(canvas, s.pos);
    });
  }

  @override
  void onMount() {
    final _scaleFactor = gameRef.size.width / ORIGINAL_SECTION_WIDTH;

    _sectionW = gameRef.size.width;
    _sectionH = ORIGINAL_SECTION_HEIGHT * _scaleFactor;

    _templates.add(Sprite('backgrounds/florest_1.png'));
    _templates.add(Sprite('backgrounds/florest_2.png'));

    _initSections();
  }

  void _initSections() {
    final ammount = gameRef.size.height / _sectionH;

    for (var i = -1; i < ammount; i++) {
      _sections.add(_newSection(i * _sectionH));
    }
  }

  _Section _newSection(double y) {
    final s = _templates[random.nextInt(_templates.length)];

    final r = Rect.fromLTWH(0, y, _sectionW, _sectionH);

    return _Section()
        ..sprite = s
        ..pos = r;
  }
}
