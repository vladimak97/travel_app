// ignore_for_file: library_private_types_in_public_api, avoid_print, duplicate_ignore

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlightsPage extends StatefulWidget {
  const FlightsPage({Key? key});

  @override
  _FlightsPageState createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController departureDateController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();

  List<dynamic> flights = [];

  Future<String> _getAccessToken() async {
    var url = Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token');
    var client = http.Client();

    var response = await client.post(url, body: {
      'grant_type': 'client_credentials',
      'client_id': 'YWcVCukFQNqVOVGYAGIkO4ShJrWWtwS2',
      'client_secret': 'LffYAS4rnxG3FrCu'
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var accessToken = jsonResponse['access_token'];
      return accessToken;
    }

    return '';
  }

  Future<List<dynamic>> searchFlights() async {
    String token = await _getAccessToken();
    String auth = 'Bearer $token';
    final headers = {'Authorization': auth};

    const String baseUrl = 'https://test.api.amadeus.com/v2/shopping/flight-offers';
    final String originLocationCode = originController.text;
    final String destinationLocationCode = destinationController.text;
    final String departureDate = departureDateController.text;
    final String returnDate = returnDateController.text;

    final Uri url = Uri.parse(
        '$baseUrl?originLocationCode=$originLocationCode&destinationLocationCode=$destinationLocationCode&departureDate=$departureDate&returnDate=$returnDate&adults=1&nonStop=true&max=1');

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      return parsedResponse['data'];
    } else {
      throw Exception('Failed to find flight offers');
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        controller.text = picked.toIso8601String().split('T')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loty'),
        centerTitle: true,
        backgroundColor: const Color(0xff192025),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              color: const Color(0xff404851),
              child: TextField(
                controller: originController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Miasto lub lotnisko odlotu',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              color: const Color(0xff404851),
              child: TextField(
                controller: destinationController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Miasto docelowe lub lotnisko',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              color: const Color(0xff404851),
              child: TextField(
                controller: departureDateController,
                readOnly: true,
                onTap: () {
                  _selectDate(context, departureDateController);
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Data odlotu',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              color: const Color(0xff404851),
              child: TextField(
                controller: returnDateController,
                readOnly: true,
                onTap: () {
                  _selectDate(context, returnDateController);
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Data powrotu',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                searchFlights().then((flights) {
                  setState(() {
                    this.flights = flights;
                  });
                }).catchError((error) {
                  print(error);
                });
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xfffd690d))),
              child: const Text(
                'Szukaj',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: flights.length,
                itemBuilder: (context, index) {
                  final flight = flights[index];
                  final itineraries = flight['itineraries'];
                  final price = flight['price'];
                  final outboundFlight = itineraries[0]['segments'][0];
                  final inboundFlight = itineraries[1]['segments'][0];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Odlot',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          Text('od: ${outboundFlight['departure']['iataCode']}', style: const TextStyle(color: Colors.black)),
                          Text('do: ${outboundFlight['arrival']['iataCode']}', style: const TextStyle(color: Colors.black)),
                          Text('${outboundFlight['departure']['at']}', style: const TextStyle(color: Colors.black)),
                          const SizedBox(height: 16),
                          const Text(
                            'Powrót',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          Text('od: ${inboundFlight['departure']['iataCode']}', style: const TextStyle(color: Colors.black)),
                          Text('do: ${inboundFlight['arrival']['iataCode']}', style: const TextStyle(color: Colors.black)),
                          Text('${inboundFlight['departure']['at']}', style: const TextStyle(color: Colors.black)),
                          const SizedBox(height: 16),
                          Text(
                            'Cena: ${price['total']} ${price['currency']}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
