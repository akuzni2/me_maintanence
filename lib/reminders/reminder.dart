class ReminderItem {
  late int id;
  late int preventative_care_id;
  late String username;
  late int next_reminder_date_epoch;

  ReminderItem.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    preventative_care_id = map['preventative_care_id'];
    username = map['username'];
    next_reminder_date_epoch = map['next_reminder_date_epoch'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'preventative_care_id': preventative_care_id,
        'username': username,
        'next_reminder_date_epoch': next_reminder_date_epoch
      };

  ReminderItem();

}
