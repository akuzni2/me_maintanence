class ReminderItem {
  int? id;
  late int preventative_care_id;
  late String username;
  late int next_reminder_date_epoch;

  ReminderItem.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    preventative_care_id = map['preventativeCareId'];
    username = map['username'];
    next_reminder_date_epoch = map['reminderDateEpoch'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> val = {
      'preventativeCareId': preventative_care_id,
      'username': username,
      'reminderDateEpoch': next_reminder_date_epoch
    };

    if (id != null) {
      val['id'] = id;
    }

    return val;
  }

  ReminderItem();
}
