import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';

class KDivider extends StatelessWidget {
  const KDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Responsive.isDesktop(context) ? defaultPadding * 2.5 : defaultPadding * 1.2),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              height: 1.0,
              thickness: 1.0,
              color: kDefaultColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Image.asset(
              'assets/icons/ether.jpeg',
              height: 20.0,
            ),
          ),
          const Expanded(
            child: Divider(
              height: 1.0,
              thickness: 1.0,
              color: kDefaultColor,
            ),
          ),
        ],
      ),
    );
  }
}
