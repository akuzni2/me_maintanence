class PreventativeCareItem {
  late int id;
  late String title;
  late String searchTerm;
  late String description;
  late String gender;
  late int ageRangeMin;
  late int ageRangeMax;
  late bool isRecurring;
  late double annualInterval;

  PreventativeCareItem.fromJson(Map<String, dynamic> map) {
    print("Got Json: $map");
    id = map['id'];
    title = map['title'];
    searchTerm = map['searchTerm'];
    description = map['description'];
    gender = map['gender'];
    ageRangeMin = map['ageRangeMin'];
    ageRangeMax = map['ageRangeMax'];
    isRecurring = map['isRecurring'];

    // have to add 0.0. https://stackoverflow.com/questions/26417782/in-dart-is-there-a-quick-way-to-convert-int-to-double
    annualInterval = map['annualInterval'] + 0.0;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'searchTerm': searchTerm,
        'gender': gender,
        'description': description,
        'isRecurring': isRecurring,
        'annualInterval': annualInterval,
        'ageRangeMin': ageRangeMin,
        'ageRangeMax': ageRangeMax
      };

  PreventativeCareItem();
}
