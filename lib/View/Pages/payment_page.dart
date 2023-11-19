// ignore_for_file: library_private_types_in_public_api, avoid_print, duplicate_ignore

import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void dispose() {
    cardNumberController.dispose();
    cardHolderNameController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  InputDecoration _customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xB3FFFFFF)),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xB3FFFFFF)),
      ),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xB3FFFFFF)),
      ),
    );
  }

  void _saveData() {
    if (_formKey.currentState!.validate()) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Metoda płatności',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff404851),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: cardHolderNameController,
                  decoration: _customInputDecoration('Imię i nazwisko posiadacza karty'),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Podaj imię i nazwisko na karcie';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: cardNumberController,
                  decoration: _customInputDecoration('Numer karty'),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Podaj numer swojej karty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: expiryDateController,
                  decoration: _customInputDecoration('Data ważności'),
                  keyboardType: TextInputType.datetime,
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wprowadź datę ważności karty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: cvvController,
                  decoration: _customInputDecoration('CVV'),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Podaj numer CVV swojej karty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveData,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xfffd690d),
                  ),
                  child: const Text('Zapisz'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
