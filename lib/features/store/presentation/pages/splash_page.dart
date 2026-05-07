import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/splash_service.dart';
import '../../../../core/injection_container.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    // Memanggil logika delay dari service
    await locator<SplashService>().startAppDelay();
    if (mounted) context.go('/'); // Pindah ke home menggunakan go_router
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.store, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "UTD Store - Rival", // Ganti dengan nama lengkapmu
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "NIM: 20123006",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
