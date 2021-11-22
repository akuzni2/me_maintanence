import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/recommendations/recommendation.dart';

class PreventativeCareListTile extends StatelessWidget {
  final PreventativeCareItem careItem;

  const PreventativeCareListTile(this.careItem);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: Material(
          child: ListTile(
              title: Text(careItem.title),
              subtitle: Text("Not Scheduled Yet"),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed("/preventative-care", arguments: careItem);
                },
              )),
        ));
  }
}
