import 'package:bonfire/bonfire.dart';
import 'package:cool_game/domain/enitities/enemies/headless_horseman.dart';
import 'package:cool_game/domain/enitities/enemies/lizardman.dart';
import 'package:cool_game/domain/enitities/enemies/minotaur.dart';
import 'package:cool_game/domain/enitities/npcs/alchemist.dart';
import 'package:cool_game/domain/enitities/npcs/blacksmith.dart';
import 'package:cool_game/domain/enitities/objects/bonfire.dart';
import 'package:cool_game/domain/enitities/objects/chest.dart';
import 'package:cool_game/domain/enitities/objects/plant.dart';
import 'package:cool_game/domain/enitities/objects/world_object.dart';

class Globals {
  Globals._();

  static final forces = _Forces();
  static final input = _Input();
  static final lottie = _Lottie();
  static final map = _Map();

  static const spriteStepTime = 0.1;
  static const tileSize = 32.0;
}

class _Input {
  static const path = 'input/';

  final aPressed = '${path}a_pressed.png';
  final aUnpressed = '${path}a_unpressed.png';
  final bPressed = '${path}b_pressed.png';
  final bUnpressed = '${path}b_unpressed.png';
  final xPressed = '${path}x_pressed.png';
  final xUnpressed = '${path}x_unpressed.png';
  final yPressed = '${path}y_pressed.png';
  final yUnpressed = '${path}y_unpressed.png';
  final leftJoystick = '${path}left_joystick.png';
}

class _Forces {
  final gravity = AccelerationForce2D(
    id: 'gravity',
    value: Vector2(0, 400),
  );
}

class _Lottie {
  final gameOver = 'assets/lotties/game_over.json';
  final gameWon = 'assets/lotties/game_won.json';
}

class _Map {
  final name = 'map.json';

  final objectsBuilder = {
    'Alchemist': (properties) => Alchemist(
          position: properties,
        ),
    'Blacksmith': (properties) => Blacksmith(
          position: properties,
        ),
    'Bonfire': (properties) => Bonfire(
          position: properties,
        ),
    'Chest': (properties) => Chest(
          position: properties,
        ),
    'Headless Horseman': (properties) => HeadlessHorseman(
          position: properties,
        ),
    'Lizardman': (properties) => Lizardman(
          position: properties,
        ),
    'Minotaur': (properties) => Minotaur(
          position: properties,
        ),
    'Plant': (properties) => Plant(
          position: properties,
        ),
    'World Object': (properties) => WorldObject(
          position: properties,
        ),
  };
}
