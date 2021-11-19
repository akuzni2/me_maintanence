import 'package:me_maintanence/config/app_config.dart';
import 'package:me_maintanence/patient/patient.dart';
import 'package:me_maintanence/recommendations/recommendation.dart';
import 'package:http/http.dart' as http;

abstract class RecommendationService {
  Future<List<RecommendedCareItem>> getRecommendedCareItems(Patient patient);
}

// class MyRecommendationService extends RecommendationService {
//   AppConfig conf = AppConfig();
//
//   @override
//   Future<List<RecommendedCareItem>> getRecommendedCareItems(
//       Patient patient) async {
//     String uri = conf.getApiUrl() + "/api/v1/recommendations";
//     String? gender = patient.gender;
//
//
//
//     if (gender != null) {
//       Map<String, String> headers = {
//         'Content-type': 'application/json',
//         'age': '50',
//         'gender': gender
//
//       final response = await http.get(Uri.parse(uri),);
//
//
//       }
//
//     }
//   }
// }
