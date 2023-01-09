import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppUser {
  String uid;
  String googleId;
  String email;
  String name;
  String gender;
  DateTime birthday;
  double weight;
  TimeOfDay wakeUpTime;
  int dailyTarget;

  AppUser(
      {required this.uid,
      required this.googleId,
      required this.email,
      required this.name,
      required this.gender,
      required this.birthday,
      required this.weight,
      required this.wakeUpTime,
      required this.dailyTarget});

  factory AppUser.fromDoc(Map<String, dynamic> doc) {
    return AppUser(
        uid: doc['uid'],
        googleId: doc['google_id'],
        email: doc['email'],
        name: doc['name'],
        gender: doc['gender'],
        birthday: (doc['birthday'] as Timestamp).toDate(),
        weight: doc['weight'],
        wakeUpTime: TimeOfDay(
            hour: doc['wake_up_time']['hour'],
            minute: doc['wake_up_time']['minute']),
        dailyTarget: doc['daily_target']);
  }
  toDoc() {
    return {
      'uid': uid,
      'google_id': googleId,
      'email': email,
      'name': name,
      'gender': gender,
      'birthday': Timestamp.fromDate(birthday),
      'weight': weight,
      'wake_up_time': {'hour': wakeUpTime.hour, 'minute': wakeUpTime.minute},
      'daily_target': dailyTarget
    };
  }
}
