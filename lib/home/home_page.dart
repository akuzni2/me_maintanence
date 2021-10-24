import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/login/login_credentials.dart';
import 'package:me_maintanence/patient/patient_service.dart';

class HomePage extends StatelessWidget {
  final LoginInfo loginInfo;
  final PatientService patientService = MyPatientService();

  HomePage({
    Key? key,
    required this.loginInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: OutlinedButton(
        onPressed: () {
          patientService.getPatient();
        },
        child: Text("Click"),
      )),
    );
  }
}
