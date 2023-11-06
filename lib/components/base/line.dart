import 'dart:ui';

import 'package:flame/components.dart';

class Line extends PositionComponent {
  late Offset pointA;
  late Offset pointB;
  final Paint paint;

  Line(this.pointA, this.pointB, this.paint);

  @override
  void render(Canvas canvas) {
    canvas.drawLine(pointA, pointB, paint);
  }

  double length() {
    return (pointA - pointB).distance;
  }
}