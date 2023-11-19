// ignore_for_file: library_private_types_in_public_api, avoid_print, duplicate_ignore

import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String _selectedLocation = 'PL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wybierz lokalizację',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff404851),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text(
                  'Polska',
                  style: TextStyle(
                    color: _selectedLocation == 'PL' ? Colors.orange : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedLocation = 'PL';
                  });
                },
              ),
              customDivider(),
              ListTile(
                title: Text(
                  'Niemcy',
                  style: TextStyle(
                    color: _selectedLocation == 'DE' ? Colors.orange : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedLocation = 'DE';
                  });
                },
              ),
              customDivider(),
              ListTile(
                title: Text(
                  'Szwajcaria',
                  style: TextStyle(
                    color: _selectedLocation == 'CH' ? Colors.orange : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedLocation = 'CH';
                  });
                },
              ),
              customDivider(),
              ListTile(
                title: Text(
                  'Wielka Brytania',
                  style: TextStyle(
                    color: _selectedLocation == 'GB' ? Colors.orange : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedLocation = 'GB';
                  });
                },
              ),
              customDivider(),
              ListTile(
                title: Text(
                  'Stany Zjednoczone',
                  style: TextStyle(
                    color: _selectedLocation == 'US' ? Colors.orange : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedLocation = 'US';
                  });
                },
              ),
              customDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget customDivider() {
    return const Divider(
      color: Colors.white70,
      height: 0.5,
      thickness: 0.7,
      indent: 16,
      endIndent: 0,
    );
  }
}
