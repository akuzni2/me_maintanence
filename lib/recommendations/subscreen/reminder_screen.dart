import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/reminders/reminder.dart';
import 'package:me_maintanence/reminders/reminder_service.dart';

import '../recommendations_context.dart';

class ReminderScreen extends StatefulWidget {
  final RecommendationsContext rctx;

  const ReminderScreen({Key? key, required this.rctx}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen>
    with AutomaticKeepAliveClientMixin {
  late DateTime _dateTime = DateTime.now();
  bool reminderExists = false;
  bool keepAlive = true;
  MyReminderService reminderService = MyReminderService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(margin: EdgeInsets.all(15), child: defaultDisplay()),
      ),
    );
  }

  Widget defaultDisplay() {
    if (reminderExists) {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Your reminder is set for",
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Text(getDateString(_dateTime),
                    style: TextStyle(fontSize: 25.0)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    label: Text("Change Date"),
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      selectDateTime();
                    },
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    label: Text("Delete Reminder"),
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      selectDateTime();
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                child: Text(
                    "This reminder is set to remind you on a recurring basis"),
              )
            ],
          ),
        ),
      );

    } else {
      return Align(
          alignment: Alignment.center,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: TextStyle(
                fontSize: 25.0,
              ),
            ),
            label: Text("Select Date"),
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              selectDateTime();
            },
          ));
    }
  }

  void selectDateTime() async {
    final DateTime? pickedDateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (pickedDateTime != null) {
      // If user picks a date it's happy path. If they only pick time it's not.
      setState(() {
        // Set a default TIME as well
        _dateTime = DateTime(
            pickedDateTime.year, pickedDateTime.month, pickedDateTime.day, 9);
        reminderExists = true;
        print("set state ${_dateTime.toLocal()}");
      });

      final TimeOfDay? selectedTime = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      );

      if (selectedTime != null) {
        setState(() {
          _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
              selectedTime.hour, selectedTime.minute);
        });
      }

    }

    saveDateTime();

    // setState(() {
    //   print("Setting widget care item title");
    //   widget.careItem.title = "THIS WAS CHANGED";
    // });
  }

  String getDateString(DateTime dateTime) {
    String date = "${_dateTime.toLocal()}".split(' ')[0];
    String time = "${_dateTime.toLocal()}".split(' ')[1];
    return date + " " + time;
  }

  void saveDateTime() {
    ReminderItem reminderItem = ReminderItem();
    reminderItem.preventative_care_id = widget.rctx.careItem.id;
    reminderItem.next_reminder_date_epoch = epochTime(_dateTime);
    reminderItem.username = widget.rctx.patient.id!;

    reminderService.createReminder(reminderItem);
  }

  /// the current time, in “seconds since the epoch”
  static int epochTime(DateTime datetime) {
    var ms = (datetime).millisecondsSinceEpoch;
    return (ms / 1000).round();
  }

  @override
  bool get wantKeepAlive {
    print("want keep alive called");
    return keepAlive;
  }
}
