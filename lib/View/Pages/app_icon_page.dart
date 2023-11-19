// ignore_for_file: library_private_types_in_public_api, avoid_print, duplicate_ignore

import 'package:flutter/material.dart';

class IconSelectionPage extends StatefulWidget {
  const IconSelectionPage({Key? key}) : super(key: key);

  @override
  _IconSelectionPageState createState() => _IconSelectionPageState();
}

class _IconSelectionPageState extends State<IconSelectionPage> {
  final List<String> availableIcons = [
    'logo.ico',
    'logo1.ico',
  ];

  String selectedIcon = 'logo.ico';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'wybierz logo',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff404851),
      ),
      body: ListView.builder(
        itemCount: availableIcons.length,
        itemBuilder: (context, index) {
          final iconName = availableIcons[index];

          return CustomIconListItem(
            iconName: iconName,
            isSelected: iconName == selectedIcon,
            onTap: () {
              setState(() {
                selectedIcon = iconName;
              });
            },
          );
        },
      ),
    );
  }
}

class CustomIconListItem extends StatelessWidget {
  final String iconName;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomIconListItem({
    Key? key,
    required this.iconName,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayText;
    switch (iconName) {
      case 'logo.ico':
        displayText = 'Klasyczna';
        break;

      case 'logo1.ico':
        displayText = 'Jasna';
        break;
      default:
        displayText = 'Nieznana';
    }

    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.grey,
      ),
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Radio(
                  value: iconName,
                  groupValue: isSelected ? iconName : null,
                  onChanged: (String? value) {
                    onTap();
                  },
                  activeColor: const Color(0xfffd690d),
                ),
                Text(
                  displayText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  'assets/icons/$iconName',
                  height: 48,
                  width: 48,
                ),
              ],
            ),
            onTap: onTap,
          ),
          const Divider(
            color: Colors.white70,
            height: 0.5,
            thickness: 0.7,
            indent: 16,
            endIndent: 16,
          ),
        ],
      ),
    );
  }
}
