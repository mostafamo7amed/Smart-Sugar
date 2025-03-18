import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationEntity {
  final String userId;
  final String id;
  final String title;
  final String body;
  final DateTime date;
  final String time;
  final String day;

  NotificationEntity({required this.userId, required this.id, required this.title, required this.body, required this.date, required this.time, required this.day});


  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
      date:  Platform.isIOS ? (json['date'] as Timestamp).toDate() : (json['date'] as Timestamp).toDate(),
      time: json['time'],
      day: json['day'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'date': date,
      'time': time,
      'day': day,
    };
  }

}