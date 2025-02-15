import 'package:bonfire/bonfire.dart';
import 'package:cool_game/domain/core/providers.dart';
import 'package:cool_game/domain/notifiers/game_progress_notifier.dart';
import 'package:cool_game/domain/entities/players/dwarf_warrior.dart';
import 'package:cool_game/presentation/my_game.dart';
import 'package:cool_game/presentation/overlays/game_over_overlay.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockWidgetRef extends Mock implements WidgetRef {}

class MockBonfireGame extends Mock implements BonfireGame {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DwarfWarrior warrior;

  late Widget gameWidget;
  late MockWidgetRef ref;
  late MockBonfireGame mockGame;

  const averageAnimationDuration = Duration(seconds: 1);

  setUp(
    () {
      ref = MockWidgetRef();

      mockGame = MockBonfireGame();

      warrior = DwarfWarrior(
        ref,
        position: Vector2.all(20),
      );

      warrior.gameRef = mockGame;

      gameWidget = ProviderScope(
        overrides: [
          Providers.gameProgressProvider.overrideWith(
            () => GameProgressNotifier(),
          )
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Consumer(
              builder: (context, ref, _) => MyGame(ref),
            ),
          ),
        ),
      );
    },
  );

  group(
    'Game Overlay',
    () {
      testWidgets(
        'Shows game overlay when player dies',
        (WidgetTester tester) async {
          await tester.pumpWidget(gameWidget);
          await tester.pump(averageAnimationDuration);

          final bonfireWidget = tester.widget<BonfireWidget>(
            find.byType(BonfireWidget),
          );

          final player = bonfireWidget.player as DwarfWarrior;

          player.onReceiveDamage(AttackOriginEnum.ENEMY, 100, null);

          await tester.pump(averageAnimationDuration);

          expect(find.byType(GameOverOverlay), findsOneWidget);

          final resetButton = find.text('Try Again?');

          expect(resetButton, findsOneWidget);

          await tester.tap(resetButton);
          await tester.pump(const Duration(milliseconds: 500));

          expect(find.byType(GameOverOverlay), findsNothing);
        },
      );
    },
  );
}
