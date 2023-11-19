// ignore_for_file: library_private_types_in_public_api, avoid_print, duplicate_ignore, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'service@go.com',
      queryParameters: {
        'subject': 'Potrzebna pomoc',
      },
    );
    final String url = emailUri.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Nie można uruchomić $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Centrum pomocy',
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
              const ListTile(
                title: Text(
                  'Szczególna pomoc i pomoc w poruszaniu się',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              customDivider(),
              const ListTile(
                title: Text(
                  'Bagaż',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              customDivider(),
              const ListTile(
                title: Text(
                  'Wizy, paszporty i dokumenty podróży',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              customDivider(),
              const ListTile(
                title: Text(
                  'Kiedy najlepiej robić rezerwację?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              customDivider(),
              const ListTile(
                title: Text(
                  'Podróżowanie ze zwierzętami domowymi',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              customDivider(),
              const ListTile(
                title: Text(
                  'Przesiadki',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              customDivider(),
              const ListTile(
                title: Text(
                  'Gdzie znaleźć potwierdzenie rezerwacji?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              customDivider(),
              const ListTile(
                title: Text(
                  'Jak dowiedzieć się, czy rezerwacja się powiodła?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              customDivider(),
              const ListTile(
                title: Text(
                  'W jaki sposób zmienić lub anulować rezerwację?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              customDivider(),
              InkWell(
                onTap: _launchEmail,
                child: const ListTile(
                  title: Text(
                    'Potrzebujesz więcej pomocy? Skontaktuj się z nami.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
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

void main() => runApp(const MaterialApp(home: HelpPage()));
