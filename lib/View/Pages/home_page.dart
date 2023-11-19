import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_app/Model/place_model.dart';
import 'package:travel_app/View/Pages/car_page.dart';
import 'package:travel_app/View/Pages/hotel_page.dart';
import 'package:travel_app/View/Pages/flights_page.dart';
import 'package:travel_app/View/Pages/train_page.dart';
import '../../Components/travel_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<IconData> icons = [
    Icons.flight,
    Icons.bed,
    Icons.car_rental,
    Icons.train,
  ];
  int clicked = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadJson());
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              SizedBox(
                height: myHeight * 0.1,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: myHeight * 0.05,
                    left: myWidth * 0.05,
                    right: myWidth * 0.05,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: myHeight * 0.065,
                            width: myWidth * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                              image: const DecorationImage(
                                image: AssetImage('assets/icons/logo.ico'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: myWidth * 0.05),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cześć, Vladimiros',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Następna podróż?',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: myHeight * 0.03,
                  left: myWidth * 0.06,
                  right: myWidth * 0.06,
                ),
                child: Center(
                  child: SizedBox(
                    height: myHeight * 0.05,
                    width: myWidth,
                    child: ListView.builder(
                      itemCount: icons.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return categoryWidget(index);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: myHeight * 0.03,
                  left: myWidth * 0.06,
                  right: myWidth * 0.06,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Polecane',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 550,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: placeList.length,
                  itemBuilder: (context, index) {
                    return TravelItem(
                      index: index,
                      item: placeList,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryWidget(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11.5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            clicked = index;
          });

          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FlightsPage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HotelPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CarPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TrainPage()),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: clicked == index
                ? const Color(0xfffd690d)
                : const Color(0xff404851),
          ),
          child: Center(
            child: Icon(
              icons[index],
              color: clicked == index ? Colors.white : Colors.grey,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }

  List myData = [];
  List<PlaceModel> placeList = [];

  Future<void> loadJson() async {
    String data = await rootBundle.loadString('assets/json/data.json');
    setState(() {
      myData = jsonDecode(data);
      placeList = myData.map((e) => PlaceModel.fromJson(e)).toList();
    });
  }
}
