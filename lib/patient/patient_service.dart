import 'package:http/http.dart' as http;
import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4.dart';
import 'dart:convert';

abstract class PatientService {
  Future<void> getPatient();
}

class MyPatientService extends PatientService {

  @override
  Future<void> getPatient() async {
    final response = await http
        .get(Uri.parse('http://hapi.fhir.org/baseR4/Patient/618773'));

    // print("Respone code ${response.statusCode}");
    // print("Response json ${response.body}");

    var patient = Patient.fromJson(jsonDecode(response.body));

    print("patient birthdate: ${patient.birthDate}");
    print("patient name: ${patient.name!.first}");
    print("patient $patient");

    // return response;
  }
}
