import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/recommendations/recommendations_context.dart';
import 'package:me_maintanence/reminders/reminder.dart';

class PreventativeCareListTile extends StatefulWidget {
  final RecommendationsContext rctx;

  const PreventativeCareListTile(this.rctx);

  @override
  State<PreventativeCareListTile> createState() =>
      _PreventativeCareListTileState();
}

class _PreventativeCareListTileState extends State<PreventativeCareListTile> {
  @override
  Widget build(BuildContext context) {
    var rem = widget.rctx.reminderItem;
    DateTime remDate = DateTime.now();
    if (rem != null) {
      remDate =
          DateTime.fromMillisecondsSinceEpoch(rem.next_reminder_date_epoch);
    }

    return Container(
        color: Colors.blue,
        child: Material(
          child: ListTile(
              title: Text(widget.rctx.careItem.title),
              subtitle: Text(getSubtitleText(widget.rctx.reminderItem)),
              trailing: IconButton(
                icon: getIcon(widget.rctx.reminderItem),
                onPressed: () async {
                  final value = await Navigator.of(context)
                      .pushNamed("/preventative-care", arguments: widget.rctx);

                  setState(() {
                    print("calling");
                  });
                },
              )),
        ));
  }

  Icon getIcon(ReminderItem? reminder) {
    if (reminder == null) {
      // reminder not set
      return Icon(Icons.add, color: Colors.grey);
    }

    if (reminder.completed) {
      return Icon(Icons.check, color: Colors.green);
    }

    return Icon(Icons.alarm_on, color: Colors.green);
  }

  String getSubtitleText(ReminderItem? reminder) {
    if (reminder == null) {
      return "Not Scheduled Yet";
    }

    DateTime remDate =
        DateTime.fromMillisecondsSinceEpoch(reminder.next_reminder_date_epoch);
    String remDateString = getDateString(remDate);
    if (reminder.completed) {
      return "Reminder sent: $remDateString";
    }

    return remDateString;
  }

  String getDateString(DateTime dateTime) {
    String year = "${dateTime.year}";
    String month = "${dateTime.month}";
    String day = "${dateTime.day}";
    String hour = "${dateTime.hour}";
    String min = dateTime.minute.toString().padLeft(2, '0');

    String time = "$year-$month-$day $hour:$min";

    return time;
  }
}
