import 'package:bonfire/bonfire.dart';

class Globals {
  Globals._();

  static final forces = _Forces();

  static const map = 'map.json';
  static const spriteStepTime = 0.1;
  static const tileSize = 32.0;
}

class _Forces {
  final gravity = AccelerationForce2D(
    id: 'gravity',
    value: Vector2(0, 400),
  );
}
