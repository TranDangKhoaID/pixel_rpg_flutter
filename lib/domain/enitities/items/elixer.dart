import 'package:cool_game/domain/enitities/items/item.dart';

class Elixer extends Item {
  Elixer()
      : super(
          id: 'elixer',
          name: 'Elixer',
          spritePath: 'item/elixer.png',
        );
}
