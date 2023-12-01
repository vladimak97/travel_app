// ignore_for_file: library_private_types_in_public_api, avoid_print, duplicate_ignore

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlightsPage extends StatefulWidget {
  const FlightsPage({super.key});

  @override
  _FlightsPageState createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController departureDateController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  String travelClassDropdown = 'Any';
  bool nonStopCheckBox = false;
  List<dynamic> flights = [];

  Future<String> _getAccessToken() async {
    var url =
        Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token');
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
    const String baseUrl =
        'https://test.api.amadeus.com/v2/shopping/flight-offers';

    final String originLocationCode = originController.text;
    final String destinationLocationCode = destinationController.text;
    final String departureDate = departureDateController.text;
    final String returnDate = returnDateController.text;
    String travelClass = travelClassDropdown;
    bool nonStop = nonStopCheckBox;

    String generatedUrl =
        '$baseUrl?originLocationCode=${originLocationCode.toUpperCase()}&destinationLocationCode=${destinationLocationCode.toUpperCase()}&departureDate=$departureDate';
    if (returnDate.isNotEmpty) {
      generatedUrl += '&returnDate=$returnDate';
    }
    generatedUrl += '&adults=1';
    if (travelClass == 'Any') {
      generatedUrl += '';
    } else if (travelClass == 'Premium Economy') {
      generatedUrl += '&travelClass=PREMIUM_ECONOMY';
    } else {
      generatedUrl += '&travelClass=${travelClass.toUpperCase()}';
    }
    generatedUrl += '&nonStop=$nonStop';
    final Uri url = Uri.parse(generatedUrl);

    final response = await http.get(url, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      return parsedResponse['data'];
    } else {
      throw Exception('Failed to find flight offers');
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    DropdownButton<String>(
                      value: travelClassDropdown,
                      dropdownColor: const Color(0xff404851),
                      onChanged: (String? value) {
                        setState(() {
                          travelClassDropdown = value!;
                        });
                      },
                      items: [
                        'Any',
                        'Economy',
                        'Premium Economy',
                        'Business',
                        'First'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Colors.white,
                              backgroundColor: Color(0xff404851),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                      value: nonStopCheckBox,
                      onChanged: (bool? value) {
                        setState(() {
                          nonStopCheckBox = value!;
                        });
                      },
                      activeColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return const Color(0xff404851);
                        },
                      ),
                    ),
                    const Text('Non-stop flights only'),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (originController.text.isEmpty ||
                    destinationController.text.isEmpty ||
                    departureDateController.text.isEmpty) {
                  return;
                }
                searchFlights().then((flights) {
                  setState(() {
                    this.flights = flights;
                  });
                }).catchError((error) {
                  print(error);
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xfffd690d),
                ),
              ),
              child: const Text(
                'Szukaj',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: flights.isEmpty
                  ? const Text(
                      'Nie znaleziono lotów dla bieżących parametrów. Spróbuj poszukać czegoś innego')
                  : ListView.builder(
                      itemCount: flights.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FlightCard(flightData: flights[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlightCard extends StatelessWidget {
  final Map<String, dynamic> flightData;

  const FlightCard({super.key, required this.flightData});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> itineraries = flightData['itineraries'];
    final Map<String, dynamic> price = flightData['price'];

    return Card(
      color: const Color(0xff404851),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Oferta ${flightData['id']}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Loty:',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            for (int i = 0; i < itineraries.length; i++)
              _buildSegmentWidget(itineraries[i]['segments']),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Cena:',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${price['currency']} ${price['total']}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentWidget(List<dynamic> segments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < segments.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Linia: ${segments[i]['carrierCode']}',
                    style: const TextStyle(color: Colors.white)),
                Text('Numer: ${segments[i]['number']}',
                    style: const TextStyle(color: Colors.white)),
                Text('Od: ${segments[i]['departure']['iataCode']}',
                    style: const TextStyle(color: Colors.white)),
                Text('Do: ${segments[i]['arrival']['iataCode']}',
                    style: const TextStyle(color: Colors.white)),
                Text(
                  'Wylot: ${segments[i]['departure']['at'].substring(0, 10)} ${segments[i]['departure']['at'].substring(11, 16)}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Przylot: ${segments[i]['arrival']['at'].substring(0, 10)} ${segments[i]['arrival']['at'].substring(11, 16)}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
