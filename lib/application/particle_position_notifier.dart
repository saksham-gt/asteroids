// The purpose of this Notifier is to provide give the generated particles to the ParticlePainter
// and to update the particles every frame.

import 'dart:async';

import 'package:asteroids/domain/particle_interface.dart';
import 'package:asteroids/repository/particle_repository.dart';
import 'package:flutter/material.dart';

import 'package:asteroids/domain/particle.dart';

class ParticlePositionNotifier extends ValueNotifier<List<Particle>> {
  final BuildContext context;

  late ParticleInterface _particleRepository;

  ParticleInterface get repository => _particleRepository;

  late Timer spawnTimer;

  ParticlePositionNotifier(this.context, super.value) {
    _particleRepository = ParticleRepositoryImpl(context);

    spawnTimer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      // Spawn new obstacles every 100 millisecs. and notify
      _particleRepository.spawnParticles();
      value = _particleRepository.particles;
    });
  }

  @override
  void dispose() {
    super.dispose();
    spawnTimer.cancel();
  }

  void updateParticles() {
    _particleRepository.eliminateParticlesOutOfViewPort();

    if (_particleRepository.particles.isEmpty) {
      _particleRepository.spawnParticles();
      value = _particleRepository.particles;
    }

    _particleRepository.detectCollisionBetweenObstacles();

    for (Particle particle in _particleRepository.particles) {
      /// Since this method is triggered by controller whenever a certain time is elapsed and triggered by ticker (60 fps),
      /// We check exactly the animation progress by controller value and move the [Particle] accordingly.
      particle.position += particle.velocity;
    }
    value = _particleRepository.particles;
    notifyListeners();
  }
}
