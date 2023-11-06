import 'dart:ui';

import 'package:flame/components.dart';
import 'package:gool/utils/utils.dart';

import 'base/circle.dart';
import 'base/line.dart';
import 'base/polygon.dart';

class Goalie {
  Vector2 position;
  Paint paint;
  Vector2 nose;
  Offset leftShoulder;
  Offset rightShoulder;
  Offset leftElbow;
  Offset rightElbow;
  Offset leftWrist;
  Offset rightWrist;
  Offset leftHip;
  Offset rightHip;
  Offset leftKnee;
  Offset rightKnee;
  Offset leftAnkle;
  Offset rightAnkle;

  static const double headRaduis = 25.0;
  late Circle head;
  late Line leftArm;
  late Line rightArm;
  late Line leftForearm;
  late Line rightForearm;
  late Line leftThigh;
  late Line rightThigh;
  late Line leftLeg;
  late Line rightLeg;
  late Polygon torso;

  Goalie(
      this.position,
      this.paint,
      this.nose,
      this.leftShoulder,
      this.rightShoulder,
      this.leftElbow,
      this.rightElbow,
      this.leftWrist,
      this.rightWrist,
      this.leftHip,
      this.rightHip,
      this.leftKnee,
      this.rightKnee,
      this.leftAnkle,
      this.rightAnkle) {
    position = position;
    head = Circle(headRaduis, nose, paint);
    leftArm = Line(leftShoulder, leftElbow, paint);
    rightArm = Line(rightShoulder, rightElbow, paint);
    leftForearm = Line(leftElbow, leftWrist, paint);
    rightForearm = Line(rightElbow, rightWrist, paint);
    leftThigh = Line(leftHip, leftKnee, paint);
    rightThigh = Line(rightHip, rightKnee, paint);
    leftLeg = Line(leftKnee, leftAnkle, paint);
    rightLeg = Line(rightKnee, rightAnkle, paint);
    torso = buildTorso();
  }

  static Goalie buildGoalie(Vector2 initialPosition) {
    const Color color = Color.fromARGB(255, 255, 0, 0);
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 5.0;

    Vector2 nose = Vector2(
        initialPosition[0] - headRaduis, initialPosition[1] - headRaduis); //0
    Offset leftShoulder =
        Offset(initialPosition[0] + 25, initialPosition[1] + 18); //5
    Offset rightShoulder =
        Offset(initialPosition[0] - 25, initialPosition[1] + 18); //6
    Offset leftElbow =
        Offset(initialPosition[0] + 50, initialPosition[1] + 43); //7
    Offset rightElbow =
        Offset(initialPosition[0] - 50, initialPosition[1] + 43); //8
    Offset leftWrist =
        Offset(initialPosition[0] + 75, initialPosition[1] + 18); //9
    Offset rightWrist =
        Offset(initialPosition[0] - 75, initialPosition[1] + 18); //10
    Offset leftHip =
        Offset(initialPosition[0] + 25, initialPosition[1] + 68); //11
    Offset rightHip =
        Offset(initialPosition[0] - 25, initialPosition[1] + 68); //12
    Offset leftKnee =
        Offset(initialPosition[0] + 50, initialPosition[1] + 93); //13
    Offset rightKnee =
        Offset(initialPosition[0] - 50, initialPosition[1] + 93); //14
    Offset leftAnkle =
        Offset(initialPosition[0] + 25, initialPosition[1] + 118); //15
    Offset rightAnkle =
        Offset(initialPosition[0] - 25, initialPosition[1] + 118); //16

    return Goalie(
        initialPosition,
        paint,
        nose,
        leftShoulder,
        rightShoulder,
        leftElbow,
        rightElbow,
        leftWrist,
        rightWrist,
        leftHip,
        rightHip,
        leftKnee,
        rightKnee,
        leftAnkle,
        rightAnkle);
  }

  void updatePosition(List<Offset> keypoints) {
    head.position =
        Vector2(keypoints[0].dx - headRaduis, keypoints[0].dy - headRaduis);
    leftArm.pointA = keypoints[5];
    leftArm.pointB = keypoints[7];
    rightArm.pointA = keypoints[6];
    rightArm.pointB = keypoints[8];
    leftForearm.pointA = keypoints[7];
    leftForearm.pointB = keypoints[9];
    rightForearm.pointA = keypoints[8];
    rightForearm.pointB = keypoints[10];
    leftThigh.pointA = keypoints[11];
    leftThigh.pointB = keypoints[13];
    rightThigh.pointA = keypoints[12];
    rightThigh.pointB = keypoints[14];
    leftLeg.pointA = keypoints[13];
    leftLeg.pointB = keypoints[15];
    rightLeg.pointA = keypoints[14];
    rightLeg.pointB = keypoints[16];
    torso.updateVertices([
      Utils.toVector2(keypoints[5]),
      Utils.toVector2(keypoints[6]),
      Utils.toVector2(keypoints[12]),
      Utils.toVector2(keypoints[11]),
      Utils.toVector2(keypoints[5])
    ]);
  }

  Polygon buildTorso() {
    late List<Vector2> torsoPoints = [];
    torsoPoints.add(Utils.toVector2(leftShoulder));
    torsoPoints.add(Utils.toVector2(rightShoulder));
    torsoPoints.add(Utils.toVector2(rightHip));
    torsoPoints.add(Utils.toVector2(leftHip));
    torsoPoints.add(Utils.toVector2(leftShoulder));
    paint.style = PaintingStyle.fill;
    return Polygon(torsoPoints, paint);
  }

  List<Line> getLines() {
    return [
      leftArm,
      rightArm,
      leftForearm,
      rightForearm,
      leftThigh,
      rightThigh,
      leftLeg,
      rightLeg
    ];
  }
}
