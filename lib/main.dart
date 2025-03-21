import 'package:asteroids/application/particle_position_notifier.dart';
import 'package:asteroids/presentation/asteroids.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: const HomeWidget()));
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final particleNotifier = ParticlePositionNotifier(context, []);

    return AsteroidsApp(particleNotifier: particleNotifier);
  }
}
