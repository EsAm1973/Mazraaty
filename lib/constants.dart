import 'package:flutter/material.dart';


const String baseUrl='https://d68a-196-129-70-74.ngrok-free.app/api/';
const Color kPrimaryColor = Colors.white;
const Color kMainColor = Color(0xff3E7B27);
const Color kScaffoldColor = Color(0xffF1F1F1);
const String testImage='assets/images/testImage.png';
const String kfontFamily = 'MagicTropic';

const List<Map<String, String>> onboardingData = [
  {
    "title": "Your Smart*\nAgricultural Partner",
    "subtitle":
        "Mazraaty is your trusted companion to diagnose plant diseases and provide actionable insights for healthier crops",
    "image": "assets/images/onboard1.png",
  },
  {
    "title": "Revolutionizing\n Agriculture\n* with AI",
    "subtitle":
        "Mazraaty leverages advanced AI technology to analyze plant images and detect diseases with precision, helping farmers achieve better yields",
    "image": "assets/images/onboard2.png",
  },
  {
    "title": "Comprehensive*\n Plant Library",
    "subtitle":
        "Mazraaty provides a complete library of plants, featuring detailed information about different species, their common diseases, and effective care methods",
    "image": "assets/images/onboard3.png",
  },
  {
    "title": "Empower Your*\n Farming Journey",
    "subtitle":
        "Join Mazraaty today to access smart tools, tailored solutions, and expert guidance for your agricultural needs",
    "image": "assets/images/onboard4.png",
  },
];

final List<Map<String, dynamic>> libraryPlantsTest = [
    {
      'title': 'Orange',
      'description': 'A refreshing vegetable high in water content, commonly used in salads and pickles.',
      'image': 'assets/images/testImage.png',
      'isFavorite': false,
    },
    {
      'title': 'Tomato',
      'description': 'A refreshing vegetable high in water content, commonly used in salads and pickles.',
      'image': 'assets/images/testImage.png',
      'isFavorite': true,
    },
    {
      'title': 'Cucumber',
      'description': 'A refreshing vegetable high in water content, commonly used in salads and pickles, A refreshing vegetable high in water content, commonly used in salads and pickles',
      'image': 'assets/images/testImage.png',
      'isFavorite': false,
    },
    {
      'title': 'Potato',
      'description': 'A refreshing vegetable high in water content, commonly used in salads and pickles.',
      'image': 'assets/images/testImage.png',
      'isFavorite': false,
    },
    {
      'title': 'Potato',
      'description': 'A refreshing vegetable high in water content, commonly used in salads and pickles.',
      'image': 'assets/images/testImage.png',
      'isFavorite': false,
    },
    {
      'title': 'Potato',
      'description': 'A refreshing vegetable high in water content, commonly used in salads and pickles.',
      'image': 'assets/images/testImage.png',
      'isFavorite': false,
    },
    {
      'title': 'Potato',
      'description': 'A refreshing vegetable high in water content, commonly used in salads and pickles.',
      'image': 'assets/images/testImage.png',
      'isFavorite': false,
    },
    {
      'title': 'Potato',
      'description': 'A refreshing vegetable high in water content, commonly used in salads and pickles.',
      'image': 'assets/images/testImage.png',
      'isFavorite': false,
    },
    // Add more items...
  ];
