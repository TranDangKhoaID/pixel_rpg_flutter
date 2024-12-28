import 'package:cool_game/domain/core/enums/game_progress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

class GameProgressNotifier extends riverpod.Notifier<GameProgress> {
  @override
  GameProgress build() {
    return GameProgress.start;
  }

  void updateProgress(GameProgress progress) => state = progress;
}
