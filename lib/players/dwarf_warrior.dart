import 'package:bonfire/bonfire.dart';
import 'package:cool_game/extensions/vector2_extensions.dart';
import 'package:cool_game/globals.dart';
import 'package:cool_game/services/modal_service.dart';
import 'package:cool_game/sprite_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

class DwarfWarrior extends PlatformPlayer with HandleForces {
  static const _size = Globals.tileSize;

  DwarfWarrior({required super.position})
      : super(
          speed: 100,
          countJumps: 2,
          size: Vector2.all(_size),
          animation: PlatformAnimations(
            idleRight: SpriteAnimations.dwarfWarriorIdle,
            runRight: SpriteAnimations.dwarfWarriorWalk,
          ),
        ) {
    addForce(Globals.forces.gravity);
  }

  @override
  void onJoystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN) {
      if (event.id == LogicalKeyboardKey.space) {
        jump();
      }

      if (event.id == LogicalKeyboardKey.keyP) {
        _togglePause();
      }
    }
    super.onJoystickAction(event);
  }

  void _togglePause() {
    final isPaused = gameRef.paused;

    isPaused ? gameRef.resumeEngine() : gameRef.pauseEngine();

    ModalService.showToast(
      title: isPaused ? 'Game resumed' : 'Game paused...',
      type: isPaused ? ToastificationType.success : ToastificationType.warning,
      icon: isPaused ? const Icon(Icons.play_arrow) : const Icon(Icons.pause),
    );
  }

  @override
  Future<void> onLoad() {
    add(size.sizeToHitbox());
    return super.onLoad();
  }
}
