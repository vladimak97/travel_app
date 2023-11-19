// ignore_for_file: library_private_types_in_public_api, avoid_print, duplicate_ignore

import 'package:flutter/material.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  String _selectedCurrency = 'EUR';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wybierz walutę',
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
                  'Euro  (€)',
                  style: TextStyle(
                    color: _selectedCurrency == 'EUR' ? Colors.orange : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedCurrency = 'EUR';
                  });
                },
              ),
              customDivider(),
              ListTile(
                title: Text(
                  'Swiss Franc  (SFr.)',
                  style: TextStyle(
                    color: _selectedCurrency == 'CHF' ? Colors.orange : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedCurrency = 'CHF';
                  });
                },
              ),
              customDivider(),
              ListTile(
                title: Text(
                  'Pound sterling  (£)',
                  style: TextStyle(
                    color: _selectedCurrency == 'GBP' ? Colors.orange : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedCurrency = 'GBP';
                  });
                },
              ),
              customDivider(),
              ListTile(
                title: Text(
                  'Polish zloty  (zł)',
                  style: TextStyle(
                    color: _selectedCurrency == 'PLN' ? Colors.orange : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedCurrency = 'PLN';
                  });
                },
              ),
              customDivider(),
              ListTile(
                title: Text(
                  'United States dollar  (\$)',
                  style: TextStyle(
                    color: _selectedCurrency == 'USD' ? Colors.orange : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedCurrency = 'USD';
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

