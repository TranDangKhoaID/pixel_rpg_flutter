import 'package:bonfire/bonfire.dart';
import 'package:cool_game/extensions/vector2_extensions.dart';
import 'package:cool_game/globals.dart';
import 'package:cool_game/sprite_animations.dart';

class DwarfWarrior extends PlatformPlayer with HandleForces {
  static const _size = Globals.tileSize;

  DwarfWarrior({required super.position})
      : super(
          size: Vector2.all(_size),
          animation: PlatformAnimations(
            idleRight: SpriteAnimations.dwarfWarriorIdle,
            runRight: SpriteAnimations.dwarfWarriorWalk,
          ),
        ) {
    addForce(Globals.forces.gravity);
  }

  @override
  Future<void> onLoad() {
    add(size.sizeToHitbox());
    return super.onLoad();
  }
}
