import 'package:flutter/animation.dart';
import 'package:flame/components/animation_component.dart';

import 'dart:ui';
import 'dart:math';

class HitEffect {
  static const double HIT_EFFECT_DURATION = 0.2;
  double _time = 0;

  final AnimationComponent comp;

  HitEffect(this.comp);

  void update(double dt) {
      _time += dt;
      final curve = Curves.easeIn.transformInternal(min(_time / HIT_EFFECT_DURATION, 1.0));
      comp.paint = Paint()..colorFilter = ColorFilter.mode(const Color(0xFF6b2643).withOpacity(min(curve, 0.8)), BlendMode.srcATop);

      if (done) {
        comp.paint = null;
      }
  }

  bool get done => _time >= HIT_EFFECT_DURATION;
}

