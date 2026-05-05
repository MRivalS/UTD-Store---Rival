import 'package:flutter/material.dart';
import 'core/injection_container.dart';
import 'core/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Menyiapkan kotak perkakas (DI) sebelum aplikasi jalan[cite: 4]
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
      routerConfig: appRouter, // Menggunakan konfigurasi go_router[cite: 4]
    );
  }
}
