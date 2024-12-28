import 'package:bonfire/bonfire.dart';
import 'package:cool_game/domain/core/enums/overlays.dart';
import 'package:cool_game/domain/enitities/enemies/headless_horseman.dart';
import 'package:cool_game/domain/enitities/enemies/lizardman.dart';
import 'package:cool_game/domain/enitities/enemies/minotaur.dart';
import 'package:cool_game/domain/core/enums/joystick_actions.dart';
import 'package:cool_game/domain/core/globals.dart';
import 'package:cool_game/domain/enitities/npcs/alchemist.dart';
import 'package:cool_game/domain/enitities/npcs/blacksmith.dart';
import 'package:cool_game/domain/enitities/objects/bonfire.dart';
import 'package:cool_game/domain/enitities/objects/chest.dart';
import 'package:cool_game/domain/enitities/objects/plant.dart';
import 'package:cool_game/domain/enitities/objects/world_object.dart';
import 'package:cool_game/domain/enitities/players/dwarf_warrior.dart';
import 'package:cool_game/presentation/game/backgrounds/parallax_background.dart';
import 'package:cool_game/presentation/game/overlays/game_over_overlay.dart';
import 'package:cool_game/presentation/game/overlays/game_won_overlay.dart';
import 'package:cool_game/presentation/game/overlays/iventory_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyGame extends StatefulWidget {
  final WidgetRef ref;
  const MyGame(this.ref, {super.key});

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  static const _buttonPadding = 32.0;
  static const _joystickSize = 100.0;
  static const _joystickPadding = EdgeInsets.only(
    left: _buttonPadding,
    bottom: _buttonPadding,
  );

  static const _marginButtonA = EdgeInsets.only(
    bottom: _buttonPadding,
    right: _buttonPadding * 2,
  );

  static const _marginButtonB = EdgeInsets.only(
    bottom: _buttonPadding * 2,
    right: _buttonPadding,
  );

  static const _marginButtonX = EdgeInsets.only(
    bottom: _buttonPadding * 2,
    right: _buttonPadding * 3,
  );

  static const _marginButtonY = EdgeInsets.only(
    bottom: _buttonPadding * 3,
    right: _buttonPadding * 2,
  );

  final _cameraConfig = CameraConfig(
    initialMapZoomFit: InitialMapZoomFitEnum.fitHeight,
    moveOnlyMapArea: true,
  );

  bool _devMode = false;
  Key _gameKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      key: _gameKey,
      debugMode: _devMode,
      showCollisionArea: _devMode,
      playerControllers: [
        Keyboard(
          config: KeyboardConfig(
            acceptedKeys: [
              LogicalKeyboardKey.space,
              LogicalKeyboardKey.keyA,
              LogicalKeyboardKey.keyB,
              LogicalKeyboardKey.keyX,
              LogicalKeyboardKey.keyY,
              LogicalKeyboardKey.keyP,
            ],
            directionalKeys: [
              KeyboardDirectionalKeys.wasd(),
              KeyboardDirectionalKeys.arrows(),
            ],
          ),
        ),
        Joystick(
          directional: JoystickDirectional(
            spriteKnobDirectional: Sprite.load(
              Globals.input.leftJoystick,
            ),
            size: _joystickSize,
            margin: _joystickPadding,
          ),
          actions: [
            JoystickAction(
              actionId: JoystickActions.buttonB,
              sprite: Sprite.load(Globals.input.bUnpressed),
              spritePressed: Sprite.load(Globals.input.bPressed),
              margin: _marginButtonB,
            ),
            JoystickAction(
              actionId: JoystickActions.buttonA,
              sprite: Sprite.load(Globals.input.aUnpressed),
              spritePressed: Sprite.load(Globals.input.aPressed),
              margin: _marginButtonA,
            ),
            JoystickAction(
              actionId: JoystickActions.buttonX,
              sprite: Sprite.load(Globals.input.xUnpressed),
              spritePressed: Sprite.load(Globals.input.xPressed),
              margin: _marginButtonX,
            ),
            JoystickAction(
              actionId: JoystickActions.buttonY,
              sprite: Sprite.load(Globals.input.yUnpressed),
              spritePressed: Sprite.load(Globals.input.yPressed),
              margin: _marginButtonY,
            ),
          ],
        )
      ],
      overlayBuilderMap: {
        Overlays.gameOver.name: (context, game) => GameOverOverlay(
              onReset: _onReset,
            ),
        Overlays.gameWon.name: (context, game) => GameWonOverlay(
              onReset: _onReset,
            ),
        Overlays.inventory.name: (context, game) => InventoryOverlay(
              player: game.player,
              onClose: () {
                game.resumeEngine();
                game.overlays.remove(Overlays.inventory.name);
              },
            )
      },
      cameraConfig: _cameraConfig,
      lightingColorGame: Colors.white.withOpacity(0.01),
      player: DwarfWarrior(
        widget.ref,
        position: Vector2.all(20),
        toggleDevMode: _toggleDevMode,
      ),
      background: ParallaxBackground(),
      onReady: _onReady,
      map: WorldMapBySpritefusion(
        WorldMapReader.fromAsset(Globals.map.name),
        objectsBuilder: Globals.map.objectsBuilder,
      ),
    );
  }

  void _onReset() {
    setState(() {
      _gameKey = UniqueKey();
    });
  }

  void _toggleDevMode() => setState(
        () {
          _devMode = !_devMode;
          _gameKey = UniqueKey();
        },
      );

  void _onReady(BonfireGameInterface i) {
    debugPrint('My game is ready');
  }
}
