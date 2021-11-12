import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class AppConfig {
  String _apiUrl = "";

  String getApiUrl() {
    if (Platform.isAndroid || Platform.isIOS) {
      return "http://localhost:8000";
    } else if (kIsWeb) {
      return const String.fromEnvironment("API_URL",
          defaultValue: "https://me-maintenance-api.herokuapp.com");
    }

    print("Returning dummy API value - so it will be WRONG");
    return _apiUrl;
  }
}
