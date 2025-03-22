import 'package:asteroids/domain/particle.dart';
import 'package:flutter/widgets.dart';

abstract interface class ParticleInterface {
  void spawnParticles({Offset? position, Offset? velocity});
  Offset randomPositionGenerator();
  double randomSizeGenerator();
  Offset randomVelocityGenerator();
  void eliminateParticlesOutOfViewPort();
  void detectCollisionBetweenObstacles();
  void resolveObstacleCollisions(int particleIndex1, int particleIndex2);

  List<Particle> get particles;
  double get minParticleSize;
  double get maxParticleSize;
  double get minVelocityAtSpawn;
  double get maxVelocityAtSpawn;
}
