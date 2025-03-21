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
  late Timer timer;

  ParticlePositionNotifier(this.context, super.value) {
    _particleRepository = ParticleRepositoryImpl(context);
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      _particleRepository.randomlySpawnParticles();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void updateParticles() {
    _particleRepository.eliminateParticlesOutOfViewPort();
    for (Particle particle in _particleRepository.particles) {
      particle.position += particle.velocity;
    }
    value = _particleRepository.particles;
    notifyListeners();
  }

  void checkCollisionBetweenObstacles() {
    
  }

  void checkCollisionBetweenPlayerAndObstacles() {}
}
