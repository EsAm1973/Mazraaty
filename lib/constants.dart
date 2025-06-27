import 'package:flutter/material.dart';

const String baseUrl = 'https://0290-197-121-150-179.ngrok-free.app/api-mobile/';
const Color kPrimaryColor = Colors.white;
const Color kMainColor = Color(0xff3E7B27);
const Color kScaffoldColor = Color(0xffF1F1F1);
const String testImage = 'assets/images/testImage.png';
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

final List<String> tags = [
  "Edible",
  "Flowering",
  "Fruit-bearing",
  "Easy",
  "Toxic",
  "Tall"
];

// قائمة النباتات المشابهة (يتم استبدالها ببيانات من API إذا لزم الأمر)
final List<Map<String, String>> similarPlants = [
  {"name": "Lemon Balm", "image": "assets/images/similar3.png"},
  {"name": "Peppermint", "image": "assets/images/similar2.png"},
  {"name": "Spearmint", "image": "assets/images/similar1.png"},
];

class RequirementItem {
  final String title;
  final String description;
  final String iconPath;

  RequirementItem(
      {required this.title, required this.description, required this.iconPath});
}

// ✅ بيانات اختبارية (يمكنك استبدالها ببيانات API)
final List<RequirementItem> requirementsData = [
  RequirementItem(
      title: "Water",
      description: "Every 2-3 Days",
      iconPath: "assets/images/droplet.png"),
  RequirementItem(
      title: "Repotting",
      description: "Every 1-2 Years",
      iconPath: "assets/images/plant-02.png"),
  RequirementItem(
      title: "Fertilizer",
      description: "Once a month",
      iconPath: "assets/images/soil-moisture-field.png"),
  RequirementItem(
      title: "Misting",
      description: "Hot, Dry Climates",
      iconPath: "assets/images/water-energy.png"),
  RequirementItem(
      title: "Pruning",
      description: "Spring, Summer",
      iconPath: "assets/images/scissor.png"),
];
