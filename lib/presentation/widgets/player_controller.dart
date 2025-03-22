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
  void updatePlayerPosition(Offset position) {
    widget.playerPositionNotifier.update(position);
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
        updateGameStatus();
      },

      onHover: (event) {
        updatePlayerPosition(event.localPosition);
        updateGameStatus();
      },

      onExit: (event) {
        updatePlayerPosition(event.localPosition);
        updateGameStatus();
      },

      child: ValueListenableBuilder(
        valueListenable: widget.playerPositionNotifier,
        builder: (context, position, child) {
          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                left: position.dx - widget.playerPositionNotifier.player.radius,
                top: position.dy - widget.playerPositionNotifier.player.radius,
                child: CustomPaint(painter: CursorPainter(position)),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CursorPainter extends CustomPainter {
  final Offset pointer;
  CursorPainter(this.pointer);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    canvas.drawCircle(pointer, 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
