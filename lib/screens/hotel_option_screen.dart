import 'package:flutter/material.dart';
import 'package:travel_app/widgets/host_info.dart';

// Class for the hotel option screen.
class HotelOptionScreen extends StatefulWidget {
  const HotelOptionScreen(
      {super.key,
      required this.offers,
      required this.hotelName,
      required this.city,
      required this.checkInDate,
      required this.checkOutDate});

  // Properties for hotel offers, hotel name, city, check-in date, and check-out date.
  final List<dynamic> offers;
  final String hotelName;
  final String city;
  final String checkInDate;
  final String checkOutDate;

  @override
  State<HotelOptionScreen> createState() {
    return _HotelOptionScreenState();
  }
}

// State class for the hotel option screen.
class _HotelOptionScreenState extends State<HotelOptionScreen> {
  @override
  Widget build(BuildContext context) {
    // Method to open host name info.
    void openHostNameInfo(String roomType, String currency, String total) {
      showModalBottomSheet(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return HostInfo(
            city: widget.city,
            hotelName: widget.hotelName,
            checkInDate: widget.checkInDate,
            checkOutDate: widget.checkOutDate,
            roomType: roomType,
            currency: currency,
            total: total,
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Wybierz opcje',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            'Dostępne opcje dla hotelu:',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.hotelName,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.offers.length,
              itemBuilder: (context, index) {
                final offer = widget.offers[index];
                final room = offer['room'];
                final price = offer['price'];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                        'Typ pokoju: ${room['typeEstimated']['category']}'),
                    subtitle:
                        Text('Cena: ${price['currency']} ${price['total']}'),
                    trailing: ElevatedButton(
                      onPressed: () => openHostNameInfo(
                          room['typeEstimated']['category'],
                          price['currency'],
                          price['total']),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                      child: Text(
                        'Wybierz',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
