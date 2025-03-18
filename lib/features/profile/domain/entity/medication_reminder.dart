import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class MedicationReminder {
  final String id;
  final String userId;
  final String name;
  final String dosage;
  final String time;
  final DateTime date;
  final List<String> days;
  final bool isActive;

  MedicationReminder({
    required this.id,
    required this.userId,
    required this.name,
    required this.dosage,
    required this.time,
    required this.days,
    required this.date,
    this.isActive = true,
  });

  factory MedicationReminder.fromJson(Map<String, dynamic> json) {
    return MedicationReminder(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      dosage: json['dosage'] ?? '',
      time:json['time'] ?? '',
      date: Platform.isIOS ? (json['date'] as Timestamp).toDate() : (json['date'] as Timestamp).toDate(),
      days: List<String>.from(json['days'] ?? []),
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'dosage': dosage,
      'time': time,
      'days': days,
      'date': date,
      'isActive': isActive,
    };
  }
}