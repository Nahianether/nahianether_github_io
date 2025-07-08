import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../../providers/ui_providers.dart';

class SocalCard extends ConsumerWidget {
  const SocalCard({
    super.key,
    required this.iconSrc,
    required this.name,
    required this.color,
    required this.onTap,
  });

  final String iconSrc, name;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardId = '$iconSrc-$name'; // Create unique ID for this social card
    final isHover = ref.watch(socialCardHoverProvider(cardId));
    final actions = UIActions(ref);
    
    return FittedBox(
      child: InkWell(
        onTap: onTap,
        onHover: (value) {
          actions.setSocialCardHover(cardId, value);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 2,
            horizontal: defaultPadding * 1.5,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              if (isHover)
                BoxShadow(
                  offset: const Offset(0, 20),
                  blurRadius: 50,
                  color: Colors.black.withValues(alpha: 0.1),
                ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                iconSrc,
                height: 70,
                width: 70,
              ),
              const SizedBox(width: defaultPadding),
              Text(name),
            ],
          ),
        ),
      ),
    );
  }
}
