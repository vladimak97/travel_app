// ignore_for_file: library_private_types_in_public_api, avoid_print, duplicate_ignore

import 'package:flutter/material.dart';
import 'app_icon_page.dart';
import 'currency_page.dart';
import 'location_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ustawienia',
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
              SwitchListTile(
                title: const Text(
                  'Włącz powiadomienia',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),

              customDivider(),

              ListTile(
                title: const Text(
                  'Wybierz ikonę aplikacji',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const IconSelectionPage()),
                  );
                },
              ),

              customDivider(),
              ListTile(
                title: const Text(
                  'Waluta',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CurrencyPage()),
                  );
                },
              ),

              customDivider(),
              ListTile(
                title: const Text(
                  'Lokalizacja',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LocationPage()),
                  );
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
