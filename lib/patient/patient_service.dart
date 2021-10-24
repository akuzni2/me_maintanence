import 'package:http/http.dart' as http;

abstract class PatientService {
  Future<http.Response> getPatient();
}

class MyPatientService extends PatientService {
  @override
  Future<http.Response> getPatient() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    print("Respone code ${response.statusCode}");
    print("Response json ${response.body}");

    return response;
  }
}
