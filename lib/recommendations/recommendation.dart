import 'dart:convert';

class RecommendedCareItem {
  late int id;
  late String title;
  late String searchTerm;
  late String description;
  late String gender;
  late int ageRangeMin;
  late int ageRangeMax;
  late bool isRecurring;
  late int annualInterval;

  RecommendedCareItem.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    searchTerm = map['searchTerm'];
    description = map['description'];
    gender = map['gender'];
    ageRangeMin = map['ageRangeMin'];
    ageRangeMax = map['ageRangeMax'];
    isRecurring = map['isRecurring'];
    annualInterval = map['annualInterval'];
  }
}
