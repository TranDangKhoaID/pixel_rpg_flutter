import 'package:bonfire/bonfire.dart';
import 'package:cool_game/domain/enitities/items/item.dart';
import 'package:cool_game/presentation/game/animations/sprite_animations.dart';

class Gem extends Item {
  Gem()
      : super(
          id: 'gem',
          name: 'Gem',
          spritePath: 'item/gem.png',
        );
}

class GemDecoration extends ItemDecoration {
  GemDecoration({
    required super.position,
  }) : super.withAnimation(
          size: Vector2.all(16),
          animation: SpriteAnimations.inventory.gem,
        );
}
