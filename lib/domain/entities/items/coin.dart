import 'package:bonfire/bonfire.dart';
import 'package:cool_game/domain/entities/items/item.dart';
import 'package:cool_game/presentation/animations/sprite_animations.dart';

class Coin extends Item {
  Coin()
      : super(
          id: 'coin',
          name: 'Coin',
          spritePath: 'item/coin.png',
        );
}

class CoinDecoration extends ItemDecoration {
  CoinDecoration({
    required super.position,
  }) : super.withAnimation(
          size: Vector2.all(10),
          animation: SpriteAnimations.inventory.coin,
        );
}
