import 'package:flutter/material.dart';
import 'View/BottomNavigationBar/nav_bar.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NavBar(),
      theme: ThemeData(

        // dekoracja aplikacji

        fontFamily: 'Questrial', // font
        scaffoldBackgroundColor: const Color(0xff192025),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          displayLarge: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
