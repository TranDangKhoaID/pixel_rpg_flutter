import 'package:cool_game/domain/core/globals.dart';
import 'package:cool_game/presentation/overlays/overlay_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class GameOverOverlay extends StatelessWidget {
  final void Function() onReset;
  const GameOverOverlay({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return OverlayContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            Globals.lottie.gameOver,
            fit: BoxFit.cover,
          ),
          const Gap(32),
          ElevatedButton(
            onPressed: onReset,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Try Again?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
