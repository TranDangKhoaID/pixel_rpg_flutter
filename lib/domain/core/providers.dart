import 'package:cool_game/domain/core/enums/game_progress.dart';
import 'package:cool_game/domain/enitities/items/item.dart';
import 'package:cool_game/domain/enitities/notifiers/game_progress_notifier.dart';
import 'package:cool_game/domain/enitities/notifiers/inventory_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Providers {
  static final inventoryProvider =
      NotifierProvider<InventoryNotifier, List<Item>>(
    InventoryNotifier.new,
  );
  static final gameProgressProvider =
      NotifierProvider<GameProgressNotifier, GameProgress>(
    GameProgressNotifier.new,
  );
}
