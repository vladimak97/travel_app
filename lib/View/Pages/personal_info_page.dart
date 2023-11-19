// ignore_for_file: library_private_types_in_public_api, avoid_print, duplicate_ignore

import 'package:flutter/material.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }

  void _saveData() {
    if (_formKey.currentState!.validate()) {
    }
  }

  InputDecoration getInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xB3FFFFFF)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xB3FFFFFF)),
      ),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xB3FFFFFF)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dane osobowe',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                  controller: nameController,
                  decoration: getInputDecoration('Imię i nazwisko'),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Podaj swoje imię i nazwisko';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: getInputDecoration('Email'),
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Podaj adres e-mail';
                    } else if (!RegExp(
                        r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Podaj prawidłowy adres e-mail';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: addressController,
                  decoration: getInputDecoration('Adres'),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Podaj swój adres';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: getInputDecoration('Numer telefonu'),
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Podaj swój numer telefonu';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: dateOfBirthController,
                  decoration: getInputDecoration('Data urodzenia'),
                  keyboardType: TextInputType.datetime,
                  style: const TextStyle (fontWeight: FontWeight.bold, color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Podaj swoją datę urodzenia';
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
