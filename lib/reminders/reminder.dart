class ReminderItem {
  late int id;
  late int preventative_care_id;
  late String username;
  late int next_reminder_date_epoch;

  ReminderItem.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    preventative_care_id = map['preventativeCareId'];
    username = map['username'];
    next_reminder_date_epoch = map['reminderDateEpoch'];
  }

  Map<String, dynamic> toJson() => {
        'preventativeCareId': preventative_care_id,
        'username': username,
        'reminderDateEpoch': next_reminder_date_epoch
      };

  ReminderItem();
}
