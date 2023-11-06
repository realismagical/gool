import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../ball.dart';

class Circle extends CircleComponent with CollisionCallbacks {
  final double circleRadius;
  late Vector2 circlePosition;
  final Paint circlePaint;
  late CircleHitbox circleHitbox;
  late bool hasCollistion = false;

  Circle(this.circleRadius, this.circlePosition, this.circlePaint)
      : super(
            radius: circleRadius, position: circlePosition, paint: circlePaint);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    circleHitbox = CircleHitbox(
        radius: circleRadius, position: Vector2.all(0.0), isSolid: true);
    add(circleHitbox);
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
}
