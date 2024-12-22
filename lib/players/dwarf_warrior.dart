import 'package:bonfire/bonfire.dart';
import 'package:cool_game/enums/joystick_actions.dart';
import 'package:cool_game/enums/platform_animations_other.dart';
import 'package:cool_game/extensions/direction_animation_extensions.dart';
import 'package:cool_game/extensions/vector2_extensions.dart';
import 'package:cool_game/globals.dart';
import 'package:cool_game/mixins/screen_boundary_checker.dart';
import 'package:cool_game/services/modal_service.dart';
import 'package:cool_game/sprite_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

class DwarfWarrior extends PlatformPlayer
    with HandleForces, MouseEventListener, ScreenBoundaryChecker, UseLifeBar {
  static const _size = Globals.tileSize * 1.5;

  final void Function() toggleDevMode;

  DwarfWarrior({
    required super.position,
    required this.toggleDevMode,
  }) : super(
          speed: 100,
          countJumps: 2,
          size: Vector2.all(_size),
          animation: PlatformAnimations(
              idleRight: SpriteAnimations.dwarfWarrior.idle,
              runRight: SpriteAnimations.dwarfWarrior.walk,
              others: {
                PlatformAnimationsOther.attackOne.name:
                    SpriteAnimations.dwarfWarrior.attack,
                PlatformAnimationsOther.hurt.name:
                    SpriteAnimations.dwarfWarrior.hurt,
                PlatformAnimationsOther.death.name:
                    SpriteAnimations.dwarfWarrior.death,
              }),
        ) {
    addForce(Globals.forces.gravity);

    setupLifeBar(
      borderRadius: BorderRadius.circular(2),
      borderWidth: 2,
      showLifeText: false,
    );
  }

  @override
  void onJoystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN) {
      if (event.id == LogicalKeyboardKey.space ||
          event.id == LogicalKeyboardKey.keyA ||
          event.id == JoystickActions.buttonA) {
        _aAction();
      }

      if (event.id == LogicalKeyboardKey.keyB ||
          event.id == JoystickActions.buttonB) {
        _bAction();
      }

      if (event.id == LogicalKeyboardKey.keyX ||
          event.id == JoystickActions.buttonX) {
        _xAction();
      }

      if (event.id == LogicalKeyboardKey.keyY ||
          event.id == JoystickActions.buttonY) {
        _yAction();
      }

      if (event.id == LogicalKeyboardKey.keyP) {
        _togglePause();
      }
    }
    super.onJoystickAction(event);
  }

  @override
  void update(double dt) {
    checkBoundaries();
    super.update(dt);
  }

  void _aAction() => jump();

  void _bAction() => playOnceOther(
        other: PlatformAnimationsOther.attackOne,
      );

  void _xAction() => ModalService.showToast(
        title: 'X Action Called...',
        type: ToastificationType.warning,
      );

  void _yAction() => ModalService.showToast(
        title: 'Y Action Called...',
        type: ToastificationType.warning,
      );

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

  @override
  void onMouseTap(MouseButton button) => toggleDevMode();
}
