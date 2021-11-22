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
    print(careItem.toJson());
    int interval = careItem.annualInterval;
    if (careItem.isRecurring) {
      if (interval >= 2) {
        return "It is recommended to perform this screening every $interval years.";
      } else if (interval == 1) {
        return "It is recommended to perform this screening every year";
      } else {
        int numberOfTimes = (1 / interval).round();
        return "It is recommended to perform this screening $numberOfTimes times per year";
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
