import 'dart:convert';

class User {
  late String username;
  late String password;
  late String phone_number;
  late String fhir_server_address;
  late String patient_id;

  User.fromJsonString(String jsonString) {
    Map<String, dynamic> userMap = jsonDecode(jsonString);
    username = userMap['name'];
    password = userMap['password'];
    phone_number = userMap['phone_number'];
    fhir_server_address = userMap['fhir_server_address'];
    patient_id = userMap['patient_id'];
  }

}
