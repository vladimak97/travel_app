import 'package:flutter/material.dart';

// Screen displayed when the app is loading
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('go4travel'),
      ),
      body: const Center(
        child: Text('Ładowanie...'),
      ),
    );
  }
}
