import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/models/flight.dart';

// Definε a FlightTicket StatefulWidget
class FlightTicket extends StatefulWidget {
  const FlightTicket({super.key});

  @override
  State<FlightTicket> createState() {
    return _FlightTicketState();
  }
}

// State class for FlightTicket widget
class _FlightTicketState extends State<FlightTicket> {
  List<Flight> _flights = [];
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBoughtFlights();
  }

  // Function to fetch bought flights
  void _loadBoughtFlights() async {
    User user = FirebaseAuth.instance.currentUser!;

    final url = Uri.https(
        'travel-app-93e16-default-rtdb.europe-west1.firebasedatabase.app',
        'users/${user.uid}/flights.json');
    final response = await http.get(url);
    // Handling response
    if (response.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<Flight> loadedItems = [];
    // Iterating through fetched flight data
    for (final item in listData.entries) {
      var array = item.value['segments'];
      loadedItems.add(
        Flight(
          passenger: item.value['passenger'],
          origin: item.value['origin'],
          destination: item.value['destination'],
          date: item.value['date'],
          currency: item.value['currency'],
          total: item.value['total'],
          pnr: item.value['pnr'],
          segments: List<String>.from(array),
        ),
      );
    }
    setState(() {
      _flights = loadedItems;
      _isLoading = false;
    });
  }

  // Function to build flight segment widget
  Widget buildSegmentWidget(List<String> segments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < segments.length; i++)
          Text(
            segments[i],
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 12,
            ),
          ),
        const SizedBox(height: 8),
      ],
    );
  }

  void _displayFlightInfo(Flight flight) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Center(
          child: Text(
            'Informacje',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PNR: ${flight.pnr}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Imię pasażera: ${flight.passenger}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Loty:',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            buildSegmentWidget(flight.segments),
            const SizedBox(height: 16),
            Text(
              'Cena:  ${flight.currency} ${flight.total}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'Nie kupiłeś jeszcze żadnych lotów',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
    if (_isLoading) {
      content = Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      );
    }
    if (_flights.isNotEmpty) {
      content = ListView.builder(
        itemCount: _flights.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Z ${_flights[index].origin} do ${_flights[index].destination} w dniu ${_flights[index].date} dla ${_flights[index].passenger}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => _displayFlightInfo(_flights[index]),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.primaryContainer,
                            ),
                          ),
                          child: Text(
                            'Wiecej informacji',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    // Returning the built content
    return content;
  }
}
