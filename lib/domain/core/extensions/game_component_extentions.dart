import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:cool_game/domain/enitities/items/coin.dart';
import 'package:cool_game/domain/enitities/items/gem.dart';
import 'package:cool_game/domain/enitities/items/potion.dart';

extension GameComponentExtentions on GameComponent {
  void dropItem() {
    final pos = Vector2(
      position.x,
      position.y - (height / 2),
    );

    final item = [
      CoinDecoration(position: pos),
      GemDecoration(position: pos),
      PotionDecoration(position: pos),
    ];

    final index = Random().nextInt(item.length);

    gameRef.add(item[index]);

    removeFromParent();
  }
}
