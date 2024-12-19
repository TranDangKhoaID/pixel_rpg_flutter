import 'package:bonfire/bonfire.dart';
import 'package:cool_game/globals.dart';
import 'package:cool_game/sprite_animations.dart';

class Alchemist extends SimpleNpc {
  Alchemist({required super.position})
      : super(
          size: Vector2.all(
            Globals.tileSize,
          ),
          animation: SimpleDirectionAnimation(
            idleRight: SpriteAnimations.alchemist,
            runRight: SpriteAnimations.alchemist,
          ),
        );
}
