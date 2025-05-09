import 'package:flutter/material.dart';

class DiseaseModel {
  final String originName;
  final String description;
  final String image;
  final String imageUrl;
  final String severity;
  final Color? severityColor;

  DiseaseModel({
    required this.originName,
    required this.description,
    required this.image,
    required this.imageUrl,
    required this.severity,
    this.severityColor,
  });

  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      originName: json['origin_name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      severity: json['serverity'] ?? 'Common',
      severityColor: json['serverityColor'] != null 
          ? Color(int.parse(json['serverityColor'])) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'origin_name': originName,
      'description': description,
      'image': image,
      'imageUrl': imageUrl,
      'serverity': severity,
      'serverityColor': severityColor?.value.toString(),
    };
  }
}