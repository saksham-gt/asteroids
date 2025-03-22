import 'package:flutter/widgets.dart';

final class Player {
  Offset position;
  double radius;
  Color color;

  Player({required this.position, required this.radius, required this.color});

  void updatePosition(Offset position) {
    this.position = position;
  }
}
