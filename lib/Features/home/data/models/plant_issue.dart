import 'package:flutter/material.dart';

class PlantIssue {
  final String name;
  final String description;
  final String image;
  final String severity;
  final Color? severityColor;

  PlantIssue({
    required this.name,
    required this.description,
    required this.image,
    this.severity = 'Common',
    this.severityColor,
  });
}