import 'package:bonfire/bonfire.dart';
import 'package:cool_game/globals.dart';
import 'package:cool_game/npcs/alchemist.dart';
import 'package:cool_game/npcs/blacksmith.dart';
import 'package:cool_game/players/dwarf_warrior.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  static const _buttonPadding = 64.0;
  static const _joystickSize = 100.0;
  static const _joystickPadding = EdgeInsets.only(
    left: _buttonPadding,
    bottom: _buttonPadding,
  );

  final _cameraConfig = CameraConfig(
    initialMapZoomFit: InitialMapZoomFitEnum.fitHeight,
    moveOnlyMapArea: true,
  );

  void _onReady(BonfireGameInterface i) {
    debugPrint('My game is ready');
  }

  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      showCollisionArea: false,
      playerControllers: [
        Keyboard(
          config: KeyboardConfig(
            acceptedKeys: [
              LogicalKeyboardKey.space,
              LogicalKeyboardKey.keyP,
            ],
            directionalKeys: [
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
        )
      ],
      cameraConfig: _cameraConfig,
      player: DwarfWarrior(
        position: Vector2.all(20),
      ),
      onReady: _onReady,
      map: WorldMapBySpritefusion(WorldMapReader.fromAsset(Globals.map),
          objectsBuilder: {
            'Alchemist': (properties) => Alchemist(
                  position: properties,
                ),
            'Blacksmith': (properties) => Blacksmith(
                  position: properties,
                ),
          }),
    );
  }
}
