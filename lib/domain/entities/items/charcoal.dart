import 'package:cool_game/domain/entities/items/item.dart';

class Charcoal extends Item {
  Charcoal()
      : super(
          id: 'charcoal',
          name: 'Charcoal',
          spritePath: 'item/charcoal.png',
        );
}
