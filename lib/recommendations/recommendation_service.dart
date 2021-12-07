import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:me_maintanence/config/app_config.dart';
import 'package:me_maintanence/patient/patient.dart';
import 'package:me_maintanence/recommendations/recommendation.dart';
import 'package:http/http.dart' as http;

abstract class RecommendationService {
  Future<List<PreventativeCareItem>> getItems(Patient patient);
}

class MyRecommendationService extends RecommendationService {
  AppConfig conf = AppConfig();
  final logger = Logger();

  @override
  Future<List<PreventativeCareItem>> getItems(Patient patient) async {
    print("calling get items");

    String? gender = patient.gender;

    List<PreventativeCareItem> items = List.empty();

    if (gender != null) {
      Map<String, String> queryParameters = {
        'age': patient.getAge().toString(),
        'gender': gender
      };

      final uri =
          Uri.https(conf.getApiUrl(), '/backend/recommendations', queryParameters);

      print("making backend call");

      final response = await http.get(uri);

      print("status code: ${response.statusCode}");
      print("Got get items response ${response.body}");

      var resJson = json.decode(response.body);

      print("decoded json ${resJson}");

      var itemsJson = resJson['items'] as List;

      print("items json ${itemsJson}");

      items = itemsJson.map((e) => PreventativeCareItem.fromJson(e)).toList();

    }

    return items;
  }
}
