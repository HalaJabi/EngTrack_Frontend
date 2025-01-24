import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryGreen = Color(0xff416d6d);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.white, offset: Offset(0, 0))
];

List<Map> categories = [
  {'name': 'Mobile', 'iconPath': 'assets/images/mobile.png'},
  {'name': 'Frontend', 'iconPath': 'assets/images/WEB.png'},
  {'name': 'Backend', 'iconPath': 'assets/images/backend.jpg'},
  {'name': 'Ai', 'iconPath': 'assets/images/aii.png'},

  
  ];

List<Map> drawerItems=[
  {
    'icon': FontAwesomeIcons.paw,
    'title' : 'Adoption'
  },
  {
    'icon': Icons.mail,
    'title' : 'Donation'
  },
  {
    'icon': FontAwesomeIcons.plus,
    'title' : 'Add pet'
  },
  {
    'icon': Icons.favorite,
    'title' : 'Favorites'
  },
  {
    'icon': Icons.mail,
    'title' : 'Messages'
  },
  {
    'icon': FontAwesomeIcons.userAlt,
    'title' : 'Profile'
  },
];