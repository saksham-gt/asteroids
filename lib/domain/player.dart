import 'package:flutter/widgets.dart';

final class Player {
  Offset position;
  Color color;

  Player({required this.position, required this.color});

  void updatePosition(Offset position) {
    this.position = position;
  }
}
