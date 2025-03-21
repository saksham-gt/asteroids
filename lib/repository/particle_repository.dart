import 'dart:math';

import 'package:asteroids/domain/particle.dart';
import 'package:asteroids/domain/particle_interface.dart';
import 'package:flutter/material.dart';

class ParticleRepositoryImpl implements ParticleInterface {
  final BuildContext context;
  List<Particle> _particles = [];
  Random random = Random();
  ParticleRepositoryImpl(this.context) {
    _particles = [];
    random = Random();
  }

  void _addParticle(Particle particle) {
    _particles.add(particle);
  }

  @override
  double get minParticleSize => 30;

  @override
  double get maxParticleSize => 100;

  @override
  double get minVelocityAtSpawn => -1; // Negative because moving left

  @override
  double get maxVelocityAtSpawn => -5; // Negative because moving left

  @override
  List<Particle> get particles => _particles;

  @override
  Offset randomPositionGenerator() {
    return Offset(
      MediaQuery.of(context).size.width +
          random.nextDouble() * MediaQuery.of(context).size.width,
      random.nextDouble() * MediaQuery.of(context).size.height,
    );
  }

  @override
  Offset randomVelocityGenerator() {
    return Offset(
      random.nextDouble() * (maxVelocityAtSpawn - minVelocityAtSpawn) +
          minVelocityAtSpawn,
      random.nextDouble() * (maxVelocityAtSpawn - minVelocityAtSpawn) +
          minVelocityAtSpawn * (random.nextBool() ? 1 : -1),
    );
  }

  // Randomly spawn particles
  @override
  void randomlySpawnParticles() {
    final particle = Particle(
      position: randomPositionGenerator(),
      velocity: randomVelocityGenerator(),
      radius: randomSizeGenerator(),
      color: Colors.red,
    );
    _addParticle(particle);
  }

  @override
  void eliminateParticlesOutOfViewPort() {
    _particles.removeWhere((particle) {
      return (particle.position.dx < 0 && particle.velocity.dx < 0) ||
          (particle.position.dy < 0 && particle.velocity.dy < 0) ||
          (particle.position.dy > MediaQuery.of(context).size.height &&
              particle.velocity.dy > 0);
    });
  }

  @override
  double randomSizeGenerator() {
    return random.nextDouble() * (maxParticleSize - minParticleSize) +
        minParticleSize;
  }
}
