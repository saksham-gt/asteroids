import 'package:flutter/material.dart';

class PlayerControllerWidget extends StatefulWidget {
  // final Offset pointer;
  const PlayerControllerWidget({super.key});

  @override
  State<PlayerControllerWidget> createState() => _PlayerControllerWidgetState();
}

class _PlayerControllerWidgetState extends State<PlayerControllerWidget> {
  final double radius = 10;
  Offset pointer = Offset.zero;

  @override
  void didChangeDependencies() {
    pointer = Offset(
      MediaQuery.of(context).size.width / 2,
      MediaQuery.of(context).size.height / 2,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onHover: (event) {
        setState(() {
          pointer = event.localPosition;
        });
      },
      onEnter: (event) {
        setState(() {
          pointer = event.localPosition;
        });
      },

      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 10),
            left: pointer.dx - radius,
            top: pointer.dy - radius,
            child: CustomPaint(painter: CursorPainter(pointer)),
          ),
        ],
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
