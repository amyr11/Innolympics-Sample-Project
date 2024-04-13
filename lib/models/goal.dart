import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_boilerplate/models/category.dart';
import 'package:flutter_boilerplate/models/frequency.dart';

class Goal {
  final String? id;
  final String name;
  double saved;
  final double price;
  final Category category;
  final DateTime targetDate;
  final Frequency frequency;
  final bool isComplete;

  Goal({
    this.id,
    required this.name,
    required this.saved,
    required this.price,
    required this.category,
    required this.targetDate,
    required this.frequency,
    this.isComplete = false,
  });

  factory Goal.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;

    return Goal(
      id: snapshot.id,
      name: data['name'],
      saved: data['saved'],
      price: data['price'],
      category: Category.fromJson(data['category']),
      targetDate: data['targetDate'].toDate(),
      frequency: Frequency.fromJson(data['frequency']),
      isComplete: data['isComplete'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'saved': saved,
      'price': price,
      'category': category.toJson(),
      'targetDate': targetDate,
      'frequency': frequency.toJson(),
      'isComplete': isComplete,
    };
  }

  double get savingsPerFrequency {
    int daysUntilTargetDate = targetDate.difference(DateTime.now()).inDays;
    // two decimal places
    return (price / (daysUntilTargetDate / frequency.daysInBetween));
  }

  void addSavings(double savings) {
    saved += savings;
  }
}
