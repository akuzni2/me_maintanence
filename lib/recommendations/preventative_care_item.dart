import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/recommendations/recommendations_context.dart';

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
              subtitle: Text(
                  rem == null ? "Not Scheduled Yet" : getDateString(remDate)),
              trailing: IconButton(
                icon: Icon(
                  rem == null ? Icons.add : Icons.alarm_on,
                color: rem == null ? Colors.grey : Colors.green,
                ),
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

  String getDateString(DateTime dateTime) {
    String year = "${dateTime.year}";
    String month = "${dateTime.month}";
    String day = "${dateTime.day}";
    String hour = "${dateTime.hour}";
    String min = "${dateTime.minute}";

    String time = "$year-$month-$day $hour:$min";

    return time;
  }
}
