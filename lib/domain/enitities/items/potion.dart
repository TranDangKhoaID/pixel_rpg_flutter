import 'package:bonfire/bonfire.dart';
import 'package:cool_game/domain/enitities/items/item.dart';
import 'package:cool_game/presentation/game/animations/sprite_animations.dart';

class Potion extends Item {
  Potion()
      : super(
          id: 'potion',
          name: 'Potion',
          spritePath: 'item/potion.png',
        );
}

class PotionDecoration extends ItemDecoration {
  PotionDecoration({
    required super.position,
  }) : super.withAnimation(
          size: Vector2.all(16),
          animation: SpriteAnimations.inventory.potion,
        );
}
