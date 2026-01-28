import 'package:flutter/material.dart';
import 'package:statusify/core/di/injection_container.dart';
import 'core/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Statusify',
      theme: ThemeData(useMaterial3: true),
      routerConfig: appRouter,
    );
  }
}
