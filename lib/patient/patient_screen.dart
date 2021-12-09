import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/patient/patient.dart' as pt;
import 'package:me_maintanence/widgets/info_card.dart';
import 'package:me_maintanence/widgets/transparent_app_bar.dart';

class PatientScreen extends StatelessWidget {
  final pt.Patient patient;

  const PatientScreen({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Patient Information"),
          elevation: 0.0,
        ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
          ),
          Center(
              child: InfoCard(
            cardTitle: "Gender",
            cardDescription: patient.gender.toString(),
            color: Colors.lightBlueAccent,
          )),
          Container(
            padding: EdgeInsets.all(5),
          ),
          Center(
              child: InfoCard(
            cardTitle: "Age",
            cardDescription: patient.getAge().toString(),
            color: Colors.lightBlue,
          )),
        ],
      ),
    );
  }
}
