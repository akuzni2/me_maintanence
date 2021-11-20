import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/recommendations/recommendation.dart';


class PreventativeCareListItemWidget extends StatelessWidget {
  final RecommendedCareItem careItem;

  const PreventativeCareListItemWidget(this.careItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextButton(
        // TODO make button depress when pressed
        style: TextButton.styleFrom(primary: Colors.deepOrange),
        onPressed: () {
          print("hi");
        },
        child: Text(
          careItem.title,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(20)),
    );
  }
}
