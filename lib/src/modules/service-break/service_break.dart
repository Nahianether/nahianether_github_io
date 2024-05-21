import 'package:flutter/material.dart';

import 'components/body.dart' show ServiceBreakBody;

class ServiceBreak extends StatelessWidget {
  const ServiceBreak({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ServiceBreakBody(),
      ),
    );
  }
}
