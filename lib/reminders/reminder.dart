class ReminderItem {
  int? id;
  late int preventative_care_id;
  late String username;
  late int next_reminder_date_epoch;
  bool completed = false;

  ReminderItem.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    preventative_care_id = map['preventativeCareId'];
    username = map['username'];
    next_reminder_date_epoch = map['reminderDateEpoch'];
    if (map.containsKey("completed")) {
      completed = map['completed'];
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> val = {
      'preventativeCareId': preventative_care_id,
      'username': username,
      'reminderDateEpoch': next_reminder_date_epoch,
      'completed': completed
    };

    // Needed because when CREATING id is null. DB creates the ID.
    if (id != null) {
      val['id'] = id;
    }

    return val;
  }

  ReminderItem();
}
