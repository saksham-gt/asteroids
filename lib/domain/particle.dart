import 'package:flutter/widgets.dart';

class Particle {
  Offset position;
  Offset velocity;
  double radius;
  Color color;
  Particle({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.color,
  });

  Particle copyWith({
    Offset? position,
    Offset? velocity,
    double? radius,
    Color? color,
  }) {
    return Particle(
      position: position ?? this.position,
      velocity: velocity ?? this.velocity,
      radius: radius ?? this.radius,
      color: color ?? this.color,
    );
  }

  @override
  String toString() {
    return 'Particle(position: $position, velocity: $velocity, radius: $radius, color: $color)';
  }

  @override
  bool operator ==(covariant Particle other) {
    if (identical(this, other)) return true;

    return other.position == position &&
        other.velocity == velocity &&
        other.radius == radius &&
        other.color == color;
  }

  @override
  int get hashCode {
    return position.hashCode ^
        velocity.hashCode ^
        radius.hashCode ^
        color.hashCode;
  }
}
