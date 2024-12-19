import 'package:bonfire/bonfire.dart';
import 'package:cool_game/globals.dart';
import 'package:cool_game/npcs/alchemist.dart';
import 'package:cool_game/npcs/blacksmith.dart';
import 'package:cool_game/players/dwarf_warrior.dart';
import 'package:flutter/material.dart';

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  final _cameraConfig = CameraConfig(
    initialMapZoomFit: InitialMapZoomFitEnum.fitHeight,
    moveOnlyMapArea: true,
  );

  final _keyboard = Keyboard(
    config: KeyboardConfig(
      enable: true,
    ),
  );

  void _onReady(BonfireGameInterface i) {
    debugPrint('My game is ready');
  }

  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      playerControllers: [_keyboard],
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
