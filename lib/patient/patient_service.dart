import 'package:http/http.dart' as http;
import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4.dart';

abstract class PatientService {
  Future<void> getPatient();
}

class MyPatientService extends PatientService {
  @override
  Future<void> getPatient() async {

    var request = FhirRequest.read(
      base: Uri.parse('http://hapi.fhir.org/baseR4'),
      type: R4ResourceType.Patient,
      id: Id('618773'),
    );
    var response = await request.request(headers: {'example': 'headers'});

    print(response);
    print(response!.toJson());

    // return response;
  }

  // @override
  // Future<http.Response> getPatient() async {
  //   final response = await http
  //       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  //
  //   print("Respone code ${response.statusCode}");
  //   print("Response json ${response.body}");
  //
  //   return response;
  // }
}
