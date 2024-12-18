import 'package:bonfire/bonfire.dart';
import 'package:cool_game/globals.dart';
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
  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      playerControllers: [_keyboard],
      cameraConfig: _cameraConfig,
      player: DwarfWarrior(
        position: Vector2.all(20),
      ),
      map: WorldMapBySpritefusion(
        WorldMapReader.fromAsset(
          Globals.map,
        ),
      ),
    );
  }
}
