import 'package:flutter/material.dart';

class MedicationReminder {
  final String id;
  final String name;
  final String dosage;
  final TimeOfDay time;
  final List<String> days;
  final bool isActive;

  MedicationReminder({
    required this.id,
    required this.name,
    required this.dosage,
    required this.time,
    required this.days,
    this.isActive = true,
  });
}