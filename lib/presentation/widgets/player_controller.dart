import 'dart:async';
import 'dart:math';

import 'package:asteroids/application/di.dart';
import 'package:asteroids/application/particle_position_notifier.dart';
import 'package:asteroids/application/player_position_notifier.dart';
import 'package:flutter/material.dart';

class PlayerControllerWidget extends StatefulWidget {
  final PlayerPositionNotifier playerPositionNotifier;
  final ParticlePositionNotifier particlePositionNotifier;
  const PlayerControllerWidget({
    required this.particlePositionNotifier,
    required this.playerPositionNotifier,
    super.key,
  });

  @override
  State<PlayerControllerWidget> createState() => _PlayerControllerWidgetState();
}

class _PlayerControllerWidgetState extends State<PlayerControllerWidget> {
  double angle = 0.0;

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      Duration(milliseconds: 100),
      (timer) => updateGameStatus(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void updatePlayerPosition(Offset position) {
    final oldPosition = widget.playerPositionNotifier.player.position;
    final startX = oldPosition.dx;
    final startY = oldPosition.dy;

    // Calculate the angle of movement using atan2
    final endX = position.dx;
    final endY = position.dy;

    angle = atan2(endY - startY, endX - startX);

    widget.playerPositionNotifier.update(position);
    updateGameStatus();
  }

  void updateGameStatus() {
    gameOverNotifier.updateStatus(
      widget.playerPositionNotifier.hasCollidedWith(
        particles: widget.particlePositionNotifier.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onEnter: (event) {
        updatePlayerPosition(event.localPosition);
        // updateGameStatus();
      },

      onHover: (event) {
        updatePlayerPosition(event.localPosition);
        // updateGameStatus();
      },

      onExit: (event) {
        updatePlayerPosition(event.localPosition);
        // updateGameStatus();
      },

      child: ValueListenableBuilder(
        valueListenable: widget.playerPositionNotifier,
        builder: (context, position, child) {
          return Stack(
            children: [
              Positioned(
                left: position.dx - 15,
                top: position.dy - 20,
                child: CustomPaint(painter: CursorPainter(angle)),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CursorPainter extends CustomPainter {
  final double angle;
  CursorPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1
          ..style = PaintingStyle.fill;
    final double triangleH = 15;
    final double triangleW = 25.0;
    final double width = size.width;
    final double height = size.height;
    canvas.rotate(angle);

    final Path trianglePath =
        Path()
          ..moveTo(width / 2 - triangleW / 2, height)
          ..lineTo(width / 2, triangleH + height)
          ..lineTo(width / 2 + triangleW / 2, height)
          ..lineTo(width / 2 - triangleW / 2, height);
    canvas.drawPath(trianglePath, paint);
    final BorderRadius borderRadius = BorderRadius.circular(15);
    final Rect rect = Rect.fromLTRB(0, 0, width, height);
    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
