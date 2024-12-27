import 'package:bonfire/bonfire.dart';
import 'package:cool_game/presentation/game/overlays/overlay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cool_game/domain/core/providers.dart';

class InventoryOverlay extends ConsumerWidget {
  final Player? player;
  final void Function() onClose;

  const InventoryOverlay({
    super.key,
    required this.player,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventory = ref.read(Providers.inventoryProvider);

    return OverlayContainer(
      title: 'Inventory',
      onClose: onClose,
      child: inventory.isEmpty
          ? Center(
              child: Text(
                'No Items',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.white),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisSpacing: 8,
                crossAxisSpacing: 64,
              ),
              itemCount: inventory.length,
              itemBuilder: (context, index) {
                final item = inventory[index];

                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        onClose();
                      },
                      child: SpriteWidget.asset(
                        path: item.spritePath,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black54,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        child: Text(
                          '${item.quantity}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }
}
