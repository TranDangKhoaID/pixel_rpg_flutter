import 'package:bonfire/bonfire.dart';
import 'package:cool_game/extensions/vector2_extensions.dart';
import 'package:cool_game/globals.dart';
import 'package:cool_game/sprite_animations.dart';

class Blacksmith extends SimpleNpc {
  Blacksmith({required super.position})
      : super(
          size: Vector2.all(
            Globals.tileSize,
          ),
          animation: SimpleDirectionAnimation(
            idleRight: SpriteAnimations.blacksmith,
            runRight: SpriteAnimations.blacksmith,
          ),
        );

  @override
  Future<void> onLoad() {
    add(size.sizeToHitbox());
    return super.onLoad();
  }
}
