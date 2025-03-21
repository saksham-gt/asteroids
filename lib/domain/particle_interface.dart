import 'package:asteroids/domain/particle.dart';
import 'package:flutter/widgets.dart';

abstract interface class ParticleInterface {
  void randomlySpawnParticles();
  Offset randomPositionGenerator();
  double randomSizeGenerator();
  Offset randomVelocityGenerator();
  void eliminateParticlesOutOfViewPort();

  List<Particle> get particles;
  double get minParticleSize;
  double get maxParticleSize;
  double get minVelocityAtSpawn;
  double get maxVelocityAtSpawn;
}
