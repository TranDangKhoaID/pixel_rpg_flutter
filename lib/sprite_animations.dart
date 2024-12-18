import 'package:bonfire/bonfire.dart';
import 'package:cool_game/globals.dart';

class SpriteAnimations {
  SpriteAnimations._();

  static const _dwarfWarriorIdle = 'dwarf_warrior/idle';
  static const _dwarfWarriorWalk = 'dwarf_warrior/walk';

  static const _dwarfWarriorIdleCount = 3;
  static const _dwarfWarriorWalkCount = 6;

  static Future<SpriteAnimation> get dwarfWarriorIdle async {
    return _spriteAnimation(
      count: _dwarfWarriorIdleCount,
      path: _dwarfWarriorIdle,
    );
  }

  static Future<SpriteAnimation> get dwarfWarriorWalk async {
    return _spriteAnimation(
      count: _dwarfWarriorWalkCount,
      path: _dwarfWarriorWalk,
    );
  }

  static Future<SpriteAnimation> _spriteAnimation({
    required int count,
    required String path,
  }) async {
    final sprites = <Sprite>[];

    for (int i = 0; i < count; i++) {
      final sprite = await Sprite.load('$path/$i.png');
      sprites.add(sprite);
    }

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: Globals.spriteStepTime,
    );
  }
}
