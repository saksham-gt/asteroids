import 'package:asteroids/presentation/widgets/player.dart';
import 'package:flutter/material.dart';

class AsteroidsApp extends StatefulWidget {
  const AsteroidsApp({super.key});

  @override
  State<AsteroidsApp> createState() => _AsteroidsAppState();
}

class _AsteroidsAppState extends State<AsteroidsApp> {
  Offset pointer = Offset.zero;

  @override
  void didChangeDependencies() {
    /// Spawning [Player] in the middle of the screen
    pointer = Offset(
      MediaQuery.of(context).size.width / 2,
      MediaQuery.of(context).size.height / 2,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        cursor: SystemMouseCursors.none,
        onHover: (event) {
          setState(() {
            pointer = event.localPosition;
          });
          print('Mouse location: ${event.localPosition}');
        },
        onEnter: (event) {
          setState(() {
            pointer = event.localPosition;
          });
          print('Mouse started location: ${event.localPosition}');
        },

        child: Player(pointer: pointer),
      ),
    );
  }
}
