import 'package:bonfire/bonfire.dart';
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
}
