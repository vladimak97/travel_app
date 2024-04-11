import 'package:flutter/material.dart';
import 'package:travel_app/screens/flight_search_screen.dart';
import 'package:travel_app/screens/hotel_search_screen.dart';

class NewBooking extends StatefulWidget {
  const NewBooking({super.key});

  @override
  State<NewBooking> createState() {
    return _NewBookingState();
  }
}

class _NewBookingState extends State<NewBooking> {
  // Function to navigate to the flight search screen
  void _searchFlight() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const FlightSearchScreen(),
      ),
    );
  }

  // Function to navigate to the hotel search screen
  void _searchHotel() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const HotelSearchScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: 110,
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/logo.ico'),
                  radius: 50,
                ),
              ),
              Text(
                'Cześć,\nNastępna podróż?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Card(
            elevation: 5,
            margin: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/flight.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: GestureDetector(
                      onTap: _searchFlight,
                      child: Row(
                        children: [
                          Text(
                            'Loty',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: Theme.of(context).colorScheme.primary,
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Card(
            elevation: 5,
            margin: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/hotel.jpeg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: GestureDetector(
                      onTap: _searchHotel,
                      child: Row(
                        children: [
                          Text(
                            'Hotele',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: Theme.of(context).colorScheme.primary,
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
