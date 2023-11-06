import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

class Utils {
  static double randomBetween(double min, double max) {
    Random random = Random();
    return random.nextDouble() * (max - min) + min;
  }

  static Vector2 toVector2(Offset value) {
    return Vector2(value.dx, value.dy);
  }
}
