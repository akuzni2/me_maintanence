import 'package:me_maintanence/patient/patient.dart';
import 'package:me_maintanence/recommendations/recommendation.dart';
import 'package:me_maintanence/reminders/reminder.dart';

class RecommendationsContext {
  late PreventativeCareItem careItem;
  late Patient patient;
  ReminderItem? reminderItem;
}
