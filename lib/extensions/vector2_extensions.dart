import 'package:bonfire/bonfire.dart';

extension Vector2Extensions on Vector2 {
  RectangleHitbox sizeToHitbox() => RectangleHitbox(
        isSolid: true,
        size: Vector2.all(x / 2),
        position: Vector2(x / 4, y / 2),
      );
}
