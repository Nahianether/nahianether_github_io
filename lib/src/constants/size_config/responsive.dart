import 'package:flutter/material.dart'
    show BuildContext, LayoutBuilder, MediaQuery, StatelessWidget, Widget;

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 600 then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= 768) {
          return desktop;
        }
        // Or less then that we called it mobile
        else {
          return mobile;
        }
      },
    );
  }
}
