import 'package:flame/components/component.dart';
import 'dart:ui';

mixin HasHitbox on PositionComponent {
  static final Paint _outlinePaint = Paint()
      ..color = Color(0xFF00B533)
      ..style = PaintingStyle.stroke;

  Rect hitBox();

  Rect calculatedHitBox() {
    final r = toRect();
    final hr = hitBox();

    return Rect.fromLTWH(
        r.left + hr.left,
        r.top + hr.top,
        hr.width,
        hr.height,
    );
  }

  bool collidesWith(HasHitbox other) => calculatedHitBox().overlaps(other.calculatedHitBox());

  void renderHitboxOutline(Canvas canvas) {
    canvas.drawRect(hitBox(), _outlinePaint);
  }
}

mixin HitableByPlayer on HasHitbox {
  void takeHit();
}
