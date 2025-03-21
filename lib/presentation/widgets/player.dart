import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final Offset pointer;
  const Player({super.key, required this.pointer});

  @override
  Widget build(BuildContext context) {
    final double playerWidth = 25.0;
    final double playerHeight = 25.0;
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 50),
          left: pointer.dx - playerWidth / 2,
          top: pointer.dy - playerHeight / 2,
          child: Container(
            height: playerHeight,
            width: playerWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SizedBox(width: playerWidth, height: playerHeight),
          ),
        ),
      ],
    );
  }
}
