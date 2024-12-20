import 'package:bonfire/bonfire.dart';
import 'package:cool_game/globals.dart';

class SpriteAnimations {
  SpriteAnimations._();

  //players
  static final dwarfWarrior = _DwarfWarrior();

  //npcs
  static final alchemist = _Alchemist();
  static final blacksmith = _Blacksmith();
  static final lizardman = _Lizardman();

  //enemies
}

class _DwarfWarrior {
  Future<SpriteAnimation> get idle async => _spriteAnimation(
        count: 3,
        path: 'dwarf_warrior/idle',
      );

  Future<SpriteAnimation> get walk async => _spriteAnimation(
        count: 6,
        path: 'dwarf_warrior/walk',
      );

  Future<SpriteAnimation> get attack async => _spriteAnimation(
        count: 6,
        path: 'dwarf_warrior/attack',
      );

  Future<SpriteAnimation> get hurt async => _spriteAnimation(
        count: 3,
        path: 'dwarf_warrior/hurt',
      );

  Future<SpriteAnimation> get death async => _spriteAnimation(
        count: 6,
        path: 'dwarf_warrior/death',
      );
}

class _Alchemist {
  Future<SpriteAnimation> get idle async => _spriteAnimation(
        count: 8,
        path: 'alchemist',
      );
}

class _Blacksmith {
  Future<SpriteAnimation> get idle async => _spriteAnimation(
        count: 7,
        path: 'blacksmith',
      );
}

//eniemes lizardman
class _Lizardman {
  Future<SpriteAnimation> get idle async => _spriteAnimation(
        count: 3,
        path: 'lizardman/idle',
      );

  Future<SpriteAnimation> get walk async => _spriteAnimation(
        count: 6,
        path: 'lizardman/walk',
      );

  Future<SpriteAnimation> get attack async => _spriteAnimation(
        count: 6,
        path: 'lizardman/attack',
      );

  Future<SpriteAnimation> get hurt async => _spriteAnimation(
        count: 3,
        path: 'lizardman/hurt',
      );

  Future<SpriteAnimation> get death async => _spriteAnimation(
        count: 6,
        path: 'lizardman/death',
      );
}

//function
Future<SpriteAnimation> _spriteAnimation({
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
