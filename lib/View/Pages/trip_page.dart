// ignore_for_file: library_private_types_in_public_api, avoid_print, duplicate_ignore

import 'package:flutter/material.dart';

class TripPage extends StatelessWidget {
  const TripPage({super.key});

  @override

  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return SafeArea(

      child: Scaffold(
        backgroundColor: const Color(0xff192025),
        body: SizedBox(
          height: myHeight,
          width: myWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Dostępne wkrótce',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: myHeight * 0.03),
              const Text(
                'Bądź na bieżąco z ciekawymi aktualizacjami !',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
