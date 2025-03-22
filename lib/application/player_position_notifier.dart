import 'dart:math';

import 'package:asteroids/domain/particle.dart';
import 'package:asteroids/domain/player.dart';
import 'package:flutter/material.dart';

class PlayerPositionNotifier extends ValueNotifier<Offset> {
  late Player _player;
  Offset startingPosition;
  PlayerPositionNotifier(this.startingPosition) : super(startingPosition) {
    _player = Player(position: super.value, radius: 10, color: Colors.white);
  }

  Player get player => _player;

  void update(Offset position) {
    _player.updatePosition(position);
    value = _player.position;
    notifyListeners();
  }

  bool hasCollidedWith({required List<Particle> particles}) {
    for (Particle particle in particles) {
      final isGameOver = _playerHasCollidingWith(
        particle: particle,
        player: player,
      );
      if (isGameOver == true) {
        return true;
      }
    }
    return false;
  }

  bool _playerHasCollidingWith({
    required Particle particle,
    required Player player,
  }) {
    final otherParticlePosition = particle.position;

    final xDistance = pow(otherParticlePosition.dx - player.position.dx, 2);
    final yDistance = pow(otherParticlePosition.dy - player.position.dy, 2);

    return sqrt(xDistance + yDistance) <= particle.radius + player.radius;
  }
}
