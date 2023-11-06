import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'ball.dart';

class Goal extends SpriteComponent with CollisionCallbacks {
  late bool hasCollistion = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(position: Vector2.all(0.0), size: size, isSolid: true));
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
