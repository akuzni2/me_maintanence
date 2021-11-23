import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen>
    with AutomaticKeepAliveClientMixin {
  late DateTime _dateTime = DateTime.now();
  bool reminderExists = false;
  bool keepAlive = true;

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
                padding: EdgeInsets.all(15),
                child: Text("${_dateTime.toLocal()}".split(' ')[0],
                    style: TextStyle(fontSize: 25.0)),
              ),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              Text("This reminder is set to remind you on a recurring basis")
            ],
          ),
        ),
      );

      // return TextButton(
      //     onPressed: () {
      //       selectDateTime();
      //     },
      //     child: Text("${_dateTime.toLocal()}".split(' ')[0],
      //         style: TextStyle(fontSize: 25.0)));
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
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    print("here");
    if (picked != null) {
      setState(() {
        _dateTime = picked;
        reminderExists = true;
        print("set state ${_dateTime.toLocal()}");
      });
    }
  }

  @override
  bool get wantKeepAlive {
    print("want keep alive called");
    return keepAlive;
  }
}
