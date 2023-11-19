// ignore_for_file: library_private_types_in_public_api, avoid_print, duplicate_ignore

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: TrainPage()));
}

class TrainPage extends StatefulWidget {
  const TrainPage({Key? key}) : super(key: key);

  @override
  State<TrainPage> createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pociągi'),
        centerTitle: true,
        backgroundColor: const Color(0xff192025),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SearchBox(
              hint: 'Miasto, lotnisko lub dworzec',
            ),

            const SizedBox(height: 10),
            const SearchBox(
              hint: 'Miasto, lotnisko lub dworzec',
            ),

            const SizedBox(height: 10),
            const DateSearchBox(
              hint: 'Data wyjazdu',
            ),

            const SizedBox(height: 10),
            const DateSearchBox(
              hint: 'Data powrotu',
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // REST API
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xfffd690d),
              ),

              child: const Text('Szukaj'),
            ),

          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatefulWidget {
  final String hint;
  const SearchBox({Key? key, required this.hint}) : super(key: key);
  @override

  _SearchBoxState createState() => _SearchBoxState();
}
class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _controller = TextEditingController();

  @override

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        fillColor: const Color(0xff404851),
        filled: true,
        border: const OutlineInputBorder(),
        labelText: widget.hint,
        labelStyle: const TextStyle(color: Colors.white),
      ),

      onChanged: (value) {
        print('Text: $value');
      },

      style: const TextStyle(color: Colors.white),
    );
  }
}

class DateSearchBox extends StatefulWidget {
  final String hint;

  const DateSearchBox({Key? key, required this.hint}) : super(key: key);

  @override
  _DateSearchBoxState createState() => _DateSearchBoxState();
}

class _DateSearchBoxState extends State<DateSearchBox> {
  late String selectedDate = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked.toLocal().toString().split(' ')[0];
        print('Date picked: $selectedDate');
      });
    }
  }

  @override

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            fillColor: const Color(0xff404851),
            filled: true,
            border: const OutlineInputBorder(),
            labelText: selectedDate == '' ? widget.hint : selectedDate,
            labelStyle: const TextStyle(color: Colors.white),
          ),

          style: const TextStyle(color: Colors.white),
        ),

      ),
    );
  }
}
