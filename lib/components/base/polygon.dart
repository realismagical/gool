import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gool/components/ball.dart';

class Polygon extends PolygonComponent with CollisionCallbacks {
  final List<Vector2> pathVertices;
  final Paint customPaint;
  late PolygonHitbox polygonHitbox;
  late bool hasCollistion = false;

  Polygon(this.pathVertices, this.customPaint)
      : super(pathVertices, paint: customPaint);

  @override
  void onLoad() {
    super.onLoad();
    polygonHitbox =
        PolygonHitbox(pathVertices, position: Vector2.all(0.0), isSolid: true);
    add(polygonHitbox);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ball) {
      hasCollistion = true;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    hasCollistion = false;
  }

  void updateVertices(List<Vector2> newVertices) {
    refreshVertices(newVertices: newVertices);
  }
}
