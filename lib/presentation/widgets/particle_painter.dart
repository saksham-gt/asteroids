import 'package:asteroids/application/particle_position_notifier.dart';
import 'package:asteroids/domain/particle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill;

    for (final particle in particles) {
      canvas.drawCircle(particle.position, particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ParticlesRenderer extends StatefulWidget {
  final ParticlePositionNotifier particleNotifier;
  const ParticlesRenderer(this.particleNotifier, {super.key});

  @override
  State<ParticlesRenderer> createState() => _ParticlesRendererState();
}

class _ParticlesRendererState extends State<ParticlesRenderer> {
  late Ticker _particlesTicker;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _particlesTicker = Ticker((elapsed) {
        updateParticles();
      });
      _particlesTicker.start();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void updateParticles() {
    widget.particleNotifier.updateParticles();
  }

  @override
  void dispose() {
    _particlesTicker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.particleNotifier,
      builder: (BuildContext context, List<Particle> obstacles, Widget? child) {
        return CustomPaint(painter: ParticlePainter(obstacles));
      },
    );
  }
}
