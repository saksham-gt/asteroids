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
  double get maxVelocityAtSpawn => -4; // Negative because moving left

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
  void spawnParticles() {
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

  // To change the velocity of obstacles if they collide with each other
  @override
  void detectCollisionBetweenObstacles() {
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        if (particles[i].isColliding(particles[j])) {
          resolveObstacleCollisions(i, j);
        }
      }
    }
  }

  // Changing velocity by the law of conservation of momentum.
  @override
  void resolveObstacleCollisions(int particleIndex1, int particleIndex2) {
    final p1 = particles[particleIndex1];
    final massP1 = pi * p1.radius * p1.radius;
    final p2 = particles[particleIndex2];
    final massP2 = pi * p2.radius * p2.radius;

    Offset delta = p1.position - p2.position;
    double distanceSquared = delta.dx * delta.dx + delta.dy * delta.dy;
    if (distanceSquared == 0) return;

    // Calculate velocity difference
    Offset velocityDiff = p1.velocity - p2.velocity;

    // Project velocity difference onto collision normal
    double dotProduct =
        (velocityDiff.dx * delta.dx + velocityDiff.dy * delta.dy) /
        distanceSquared;

    if (dotProduct > 0) return; // Ignore if moving away from each other

    // Compute momentum exchange using conservation of momentum
    double massFactor = (2 * massP2) / (massP1 + massP2);
    Offset impulse = Offset(
      massFactor * dotProduct * delta.dx,
      massFactor * dotProduct * delta.dy,
    );
    p1.velocity -= impulse;

    massFactor = (2 * massP1) / (massP1 + massP2);
    impulse = Offset(
      massFactor * dotProduct * delta.dx,
      massFactor * dotProduct * delta.dy,
    );
    p2.velocity += impulse;
  }
}
