import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travel_app/View/Pages/home_page.dart';
import 'package:travel_app/View/Pages/profile_page.dart';
import 'package:travel_app/View/Pages/trip_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  static List<Widget> pages = [
    const HomePage(),
    const TripPage(),
    const ProfilePage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: pages,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),

        bottomNavigationBar: GNav(
          tabBorderRadius: 10,
          gap: 8,
          color: Colors.grey,
          activeColor: Colors.white,
          iconSize: 24,
          tabBackgroundColor: const Color(0xfffd690d),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          tabMargin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          tabs: const [
            GButton(
              icon: Icons.home_filled,
              text: 'Szukaj',
            ),
            GButton(
              icon: Icons.card_travel_rounded,
              text: 'Podróże',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profil',
            ),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ),
      ),
    );
  }
}
