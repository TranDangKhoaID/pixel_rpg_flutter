import 'package:bonfire/bonfire.dart';
import 'package:cool_game/domain/core/enums/platform_animations_other.dart';
import 'package:cool_game/domain/core/extensions/direction_animation_extensions.dart';
import 'package:cool_game/domain/core/extensions/game_component_extentions.dart';
import 'package:cool_game/domain/core/extensions/platform_enemy_extensions.dart';
import 'package:cool_game/domain/core/extensions/vector2_extensions.dart';
import 'package:cool_game/domain/core/globals.dart';
import 'package:cool_game/domain/core/mixins/screen_boundary_checker.dart';
import 'package:cool_game/presentation/animations/sprite_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Lizardman extends PlatformEnemy
    with HandleForces, ScreenBoundaryChecker, UseLifeBar {
  static const _size = Globals.tileSize * 1.5;

  final WidgetRef ref;

  Lizardman(
    this.ref, {
    required super.position,
  }) : super(
          life: 50,
          size: Vector2.all(_size),
          animation: PlatformAnimations(
            idleRight: SpriteAnimations.lizardman.idle,
            runRight: SpriteAnimations.lizardman.walk,
            others: {
              PlatformAnimationsOther.attackOne.name:
                  SpriteAnimations.lizardman.attack,
              PlatformAnimationsOther.hurt.name:
                  SpriteAnimations.lizardman.hurt,
              PlatformAnimationsOther.death.name:
                  SpriteAnimations.lizardman.death,
            },
          ),
        ) {
    addForce(Globals.forces.enemyGravity);

    setupLifeBar(
      borderRadius: BorderRadius.circular(2),
      borderWidth: 2,
      showLifeText: false,
    );
  }

  @override
  void update(double dt) {
    if (dt > Globals.deltaThreshold) return;
    if (gameRef.sceneBuilderStatus.isRunning) return;
    checkBoundaries();
    seeAndMoveToPlayer(
      movementAxis: MovementAxis.horizontal,
      closePlayer: (player) {
        animation?.showStroke(Colors.red, 2);

        if (canGiveDamage(player)) {
          simpleAttackMelee(
            damage: 5,
            size: size,
            execute: () => playOnceOther(
              onStart: () => playSoundEffect(
                Globals.audio.lizardManAttack,
                ref,
              ),
              other: PlatformAnimationsOther.attackOne,
            ),
          );
        }
      },
      notObserved: () {
        animation?.hideStroke();
        return true;
      },
    );
    super.update(dt);
  }

  @override
  Future<void> onLoad() {
    add(size.actorToHitbox());
    return super.onLoad();
  }

  @override
  void onReceiveDamage(
    AttackOriginEnum attacker,
    double damage,
    identify,
  ) {
    if (canReceiveDamage(gameRef.player!)) {
      if (damage < life) {
        playOnceOther(
          onStart: () => playSoundEffect(
            Globals.audio.lizardManHurt,
            ref,
          ),
          other: PlatformAnimationsOther.hurt,
        );
      }
      super.onReceiveDamage(attacker, damage, identify);
    }
  }

  @override
  void onDie() {
    playOnceOther(
      onStart: () => playSoundEffect(
        Globals.audio.lizardManDie,
        ref,
      ),
      other: PlatformAnimationsOther.death,
      onFinish: () => dropItem(),
    );
    super.onDie();
  }
}
