import 'package:flutter/material.dart' show BuildContext, MaterialApp, MediaQuery, TextScaler, Widget, ThemeData, ColorScheme, Brightness;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ConsumerWidget, WidgetRef;

import 'constants/constants.dart' show appName, bgColor;
import 'modules/router/view/router.dart' show AppRouter;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      restorationScopeId: appName,
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: bgColor,
          brightness: Brightness.dark,
        ),
      ),
      home: const AppRouter(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child ?? const AppRouter(),
        );
      },
    );
  }
}
