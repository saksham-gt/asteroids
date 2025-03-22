import 'package:asteroids/presentation/asteroids.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: HomeWidget()));
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AsteroidsApp();
  }
}
