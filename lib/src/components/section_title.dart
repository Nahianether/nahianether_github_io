import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/size_config/size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.subTitle,
    required this.color,
  });

  final String title, subTitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1110),
      height: 80,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: defaultPadding),
            padding: const EdgeInsets.only(bottom: 72.0),
            width: 8.0,
            height: 80.0,
            color: black,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: mainSpaceEvenly,
            crossAxisAlignment: crossStart,
            children: [
              Text(
                subTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  color: kTextColor,
                ),
                textScaler: const TextScaler.linear(0.9),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
