import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/home/care_item.dart';
import 'package:me_maintanence/home/dummy_data.dart';
import 'package:me_maintanence/patient/patient.dart' as pt;
import 'package:me_maintanence/patient/patient_service.dart';

class HomePage extends StatefulWidget {
  final pt.Patient patient;
  final PatientService patientService = MyPatientService();

  HomePage({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PatientService patientService = MyPatientService();

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    print("Got patient ${widget.patient}");

    var patientName = patientService.getPatientName(widget.patient);


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "${patientName.given!.first}",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Recommended Preventative Care",
                  style: TextStyle(
                      color: Colors.black, fontSize: 20 * textScale)),
            ),
            Expanded(
              child: GridView(
                  padding: const EdgeInsets.all(25),
                  children: DUMMY_DATA
                      .map((careItem) => new PreventativeCareItem(careItem.title))
                      .toList(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      childAspectRatio: 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20)),
            ),
          ],
        ));


    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "${patientName.given!.first}",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          elevation: 0.0,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text("Recommended Preventative Care",
                    style: TextStyle(
                        color: Colors.black, fontSize: 20 * textScale)),
              ),
              Padding(padding: const EdgeInsets.all(10)),
              GridView(
                  padding: const EdgeInsets.all(25),
                  children: DUMMY_DATA
                      .map((careItem) => new PreventativeCareItem(careItem.title))
                      .toList(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20))
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return true;
      },
    );
  }
}
