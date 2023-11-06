import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:gool/components/goal.dart';

import '../utils/utils.dart';
import 'goalie.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class Ball extends SpriteComponent with HasGameRef, CollisionCallbacks {
  static const double kickDuration = 1.0;
  static const double endScale = 0.6;
  late Vector2 initialPosition;
  late Vector2 targetPoint;
  late double endRadio;
  late CircleHitbox hitBox;
  static late bool save;

  late Goal goal;
  late double parabolaGoalOffset;
  late Goalie goalie;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    endRadio = (size.x * endScale) / 2;
    parabolaGoalOffset = Utils.randomBetween(0, 50);
    hitBox = CircleHitbox(radius: size.x / 2, position: Vector2.all(0.0));
    sprite = await gameRef.loadSprite('ball.png');
    position = initialPosition;
    targetPoint = randomBallTargetPoint();
    add(hitBox);
    kick();
  }

  void kick() {
    Vector2 curl = Vector2(
        x -
            Utils.randomBetween(goal.x - parabolaGoalOffset,
                goal.x + goal.size[0] + parabolaGoalOffset),
        -(y -
            Utils.randomBetween(targetPoint[1] + (y - targetPoint[1]) / 2, y)));
    double angle = targetPoint[0] < curl[0] ? -2 * pi : 2 * pi;
    add(RotateEffect.by(
      angle,
      EffectController(duration: kickDuration),
    ));
    add(ScaleEffect.by(
      Vector2.all(endScale),
      EffectController(duration: kickDuration),
    ));
    add(MoveAlongPathEffect(
      Path()
        ..quadraticBezierTo(curl[0], curl[1], targetPoint[0], targetPoint[1]),
      EffectController(duration: kickDuration),
      onComplete: () {
        save = false;
        if (goalie.head.hasCollistion || goalie.torso.hasCollistion) {
          save = true;
        } else {
          goalie.getLines().forEach((line) {
            double distance1 = center.distanceTo(Utils.toVector2(line.pointA));
            double distance2 = center.distanceTo(Utils.toVector2(line.pointB));
            if (distance1 + distance2 <= line.length() + endRadio) {
              save = true;
            }
          });
        }
        if (save && goal.hasCollistion) {
          FlameAudio.play('ball.mp3');
          html.window.parent?.postMessage(1, "*");
        }
        position = initialPosition;
        targetPoint = randomBallTargetPoint();
        add(ScaleEffect.to(
          Vector2.all(1.0),
          EffectController(duration: 0),
        ));
        kick();
      },
    ));
  }

  Vector2 randomBallTargetPoint() {
    return Vector2(x - Utils.randomBetween(goal.x, goal.x + goal.size[0]),
        -(y - Utils.randomBetween(goal.y, goal.y + goal.size[1])));
  }
}
