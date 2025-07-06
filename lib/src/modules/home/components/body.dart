import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../constants/size_config/responsive.dart';
import 'desktop_body.dart';
import 'mobile_body.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: Responsive(
        mobile: const MobileBody(),
        desktop: const DesktopBody(),
      ),
    );
  }
}
