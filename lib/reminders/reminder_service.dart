import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:me_maintanence/config/app_config.dart';
import 'package:me_maintanence/patient/patient.dart';
import 'package:me_maintanence/reminders/reminder.dart';

class MyReminderService {
  AppConfig conf = AppConfig();

  Future<Map<int, ReminderItem>> getReminders(Patient patient) async {
    Map<int, ReminderItem> reminders = {};

    final uri =
        Uri.https(conf.getApiUrl(), '/api/user/${patient.id}/reminders');

    final response = await http.get(uri);

    print("status code: ${response.statusCode}");
    print("Got get items response ${response.body}");

    var resJson = json.decode(response.body);

    var itemsJson = resJson['items'] as List;

    itemsJson.forEach((element) {
      var reminderItem = ReminderItem.fromJson(element);
      reminders.putIfAbsent(reminderItem.id, () => reminderItem);
    });

    return reminders;
  }

  Future<void> deleteReminder(ReminderItem reminderItem) async {
    final uri = Uri.https(conf.getApiUrl(),
        '/api/user/${reminderItem.username}/reminders/${reminderItem.id}');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      print("error deleting item");
      print("status code: ${response.statusCode}");
    }
  }

  Future<void> updateReminder(ReminderItem reminderItem) async {
    final uri = Uri.https(
        conf.getApiUrl(), '/api/user/${reminderItem.username}/reminders');

    final response = await http.put(uri);

    if (response.statusCode != 200) {
      print("error updating item");
      print("status code: ${response.statusCode}");
    }
  }

  Future<void> createReminder(ReminderItem reminderItem) async {
    print("callig create reminder service");
    final uri = Uri.https(
        conf.getApiUrl(), '/api/user/${reminderItem.username}/reminders');
    print("reminder: ${reminderItem.toJson()}");

    Map<String, String> headers = {'Content-type': 'application/json'};

    final response =
        await http.post(uri, body: jsonEncode(reminderItem.toJson()), headers: headers);

    if (response.statusCode != 200) {
      print("error creating item");
      print("status code: ${response.statusCode} | msg ${response.body}");
    } else {
      print("successfully created reminder");
    }
    print("calling complete");
  }
}
