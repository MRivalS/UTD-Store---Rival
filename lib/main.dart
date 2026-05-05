import 'package:flutter/material.dart';
import 'core/injection_container.dart';
import 'core/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'UTD Store & Crypto Hub',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter, 
    );
  }
}
