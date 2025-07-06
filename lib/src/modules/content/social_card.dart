import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class SocalCard extends StatefulWidget {
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
  SocalCardState createState() => SocalCardState();
}

class SocalCardState extends State<SocalCard> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: InkWell(
        onTap: widget.onTap,
        onHover: (value) {
          setState(() {
            isHover = value;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 2,
            horizontal: defaultPadding * 1.5,
          ),
          decoration: BoxDecoration(
            color: widget.color,
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
                widget.iconSrc,
                height: 70,
                width: 70,
              ),
              const SizedBox(width: defaultPadding),
              Text(widget.name),
            ],
          ),
        ),
      ),
    );
  }
}
