import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;

import 'src/app.dart' show MyApp;

void main() async => await _init().then((_) => runApp(const ProviderScope(child: MyApp())));

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
}
