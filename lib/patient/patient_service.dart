import 'package:http/http.dart' as http;
import 'package:me_maintanence/patient/patient.dart';
import 'dart:convert';

import 'package:me_maintanence/user/user.dart';

abstract class PatientService {
  Future<Patient> getPatient(User user);

  Name getPatientName(Patient patient);
}

class MyPatientService extends PatientService {
  @override
  Future<Patient> getPatient(User user) async {
    String uri = "${user.fhir_server_address}/Patient/${user.patient_id}";

    print("Making API request to: $uri");

    final response = await http.get(Uri.parse(uri));

    print("Response code ${response.statusCode}");
    print("Response json ${response.body}");

    var patient = Patient.fromJson(jsonDecode(response.body));

    print("patient birthdate: ${patient.birthDate}");
    print("patient name: ${patient.name!.first}");
    print("patient $patient");
    return patient;
    // return response;
  }

  @override
  Name getPatientName(Patient patient) {
    List<Name>? names = patient.name;

    final name = names!.singleWhere((element) =>
      element.use == 'official', orElse: (){
        return names.first;
    });
    
    return name;
  }
}
