// The purpose of this Notifier is to provide give the generated particles to the ParticlePainter
// and to update the particles every frame.

import 'dart:async';

import 'package:asteroids/domain/particle_interface.dart';
import 'package:asteroids/repository/particle_repository.dart';
import 'package:flutter/material.dart';

import 'package:asteroids/domain/particle.dart';

class ParticlePositionNotifier extends ValueNotifier<List<Particle>> {
  final Size size;

  late ParticleInterface _particleRepository;

  ParticleInterface get repository => _particleRepository;

  late Timer spawnTimer;

  ParticlePositionNotifier(this.size, super.value) {
    _particleRepository = ParticleRepositoryImpl(size);

    spawnTimer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      // Spawn new obstacles every 200 ms and notify
      _particleRepository.spawnParticles();
      value = _particleRepository.particles;
    });
  }

  @override
  void dispose() {
    super.dispose();
    spawnTimer.cancel();
  }

  void generateNParticles(
    int n, {
    Offset? withVelocity,
    Offset? startingPosition,
  }) {
    for (int i = 0; i < n; i++) {
      _particleRepository.spawnParticles(
        position: startingPosition,
        velocity: withVelocity,
      );
      value = _particleRepository.particles;
    }
  }

  void updateParticles() {
    _particleRepository.eliminateParticlesOutOfViewPort();

    if (_particleRepository.particles.isEmpty) {
      _particleRepository.spawnParticles();
    }

    _particleRepository.detectCollisionBetweenObstacles();

    for (Particle particle in _particleRepository.particles) {
      particle.position += particle.velocity;
    }
    value = _particleRepository.particles;
    notifyListeners();
  }
}
