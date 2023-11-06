import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gool/components/goal.dart';
import 'components/ball.dart';
import 'components/goalie.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void main() {
  runApp(GameWidget(game: Game()));
}

class Game extends FlameGame with HasCollisionDetection {
  SpriteComponent background = SpriteComponent();
  late Goal goal = Goal();
  late Goalie goalie;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final screenWidth = size[0];
    final screenHeight = size[1];
    final goalSize = Vector2(screenWidth / 2.135, screenHeight / 2.4);
    goalie = Goalie.buildGoalie(Vector2(screenWidth / 2, screenHeight * 2 / 3));
    final ballSize = Vector2(50, 50);
    late Ball ball;
    late Vector2 initialBallPosition;
    initialBallPosition =
        Vector2(screenWidth / 2 - ballSize[0] / 2, screenHeight * 3 / 4);
    goal
      ..sprite = await loadSprite('goal.png')
      ..size = goalSize
      ..x = screenWidth / 2 - goalSize[0] / 2
      ..y = screenHeight / 2 - goalSize[1];
    ball = Ball()
      ..size = ballSize
      ..initialPosition = initialBallPosition
      ..goal = goal
      ..goalie = goalie;

    add(background
      ..sprite = await loadSprite('background.png')
      ..size = size);
    add(goal);
    paintGoalie(goalie);
    add(ball);
    html.window.addEventListener('message', listen, true);
  }

  void paintGoalie(Goalie goalie) {
    add(goalie.head);
    add(goalie.leftArm);
    add(goalie.rightArm);
    add(goalie.leftForearm);
    add(goalie.rightForearm);
    add(goalie.leftThigh);
    add(goalie.rightThigh);
    add(goalie.leftLeg);
    add(goalie.rightLeg);
    add(goalie.torso);
  }

  void updateGoalie(Goalie goalie, List<Offset> keypoints) {
    keypoints = keypoints
        .map((keypoint) => Offset(goal.x + (1 - keypoint.dx) * goal.size[0],
            goal.y + keypoint.dy * goal.size[1]))
        .toList();
    goalie.updatePosition(keypoints);
  }

  void listen(html.Event event) {
    var data = (event as html.MessageEvent).data;
    late List<Offset> keypoints = [];
    if (data is List) {
      for (var keypoint in data) {
        keypoints.add(Offset(keypoint['x'], keypoint['y']));
      }
      updateGoalie(goalie, keypoints);
    }
  }
}
