import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:smart_sugar/features/diet/domain/entities/diabetes_data.dart';

Future<DiabetesData> loadDiabetesData() async {
  final String response = await rootBundle.loadString('assets/json/diabetes_data.json');
  final data = await json.decode(response);
  return DiabetesData.fromJson(data);
}
