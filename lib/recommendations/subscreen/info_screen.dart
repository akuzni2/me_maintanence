import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/recommendations/recommendation.dart';
import 'package:me_maintanence/widgets/info_card.dart';

class PreventativeCareInfoScreen extends StatelessWidget {
  final PreventativeCareItem careItem;

  const PreventativeCareInfoScreen({Key? key, required this.careItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: TransparentAppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
          ),
          Center(
              child: InfoCard(
            cardTitle: "General Description",
            cardDescription: careItem.description,
            color: Colors.lightBlueAccent,
          )),
          Container(
            padding: EdgeInsets.all(5),
          ),
          Center(
              child: InfoCard(
            cardTitle: "Frequency",
            cardDescription: getAnnualIntervalText(careItem),
            color: Colors.lightBlue,
          )),
          Container(
            padding: EdgeInsets.all(5),
          ),
          Center(
              child: InfoCard(
            cardTitle: "Who is this for?",
            cardDescription: getWhoIsThisForText(careItem),
            color: Colors.lightBlue,
          )),
        ],
      ),
    );
  }

  String getAnnualIntervalText(PreventativeCareItem careItem) {
    double interval = careItem.annualInterval;

    if (careItem.isRecurring) {
      num numYears = (1 / interval).round();
      print("num years: $numYears");
      if (numYears >= 2) {
        return "It is recommended to perform this screening every $numYears years.";
      } else if (numYears == 1) {
        return "It is recommended to perform this screening every year";
      } else {
        return "It is recommended to perform this screening $interval times per year";
      }
    } else {
      return "It is recommended to perform this screening at least once. "
          "Consult with your physician if recurring screenings would be beneficial";
    }
  }

  String getWhoIsThisForText(PreventativeCareItem careItem) {
    if (careItem.ageRangeMax > 100) {
      return "This is recommended for everyone older than ${careItem.ageRangeMin}";
    } else {
      return "This is recommended for people between the ages of ${careItem.ageRangeMin} and ${careItem.ageRangeMax}";
    }
  }
}
