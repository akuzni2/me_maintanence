import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class AppConfig {
  String _apiUrl = "";

  String getApiUrl() {
    // print("Default platform is: ${defaultTargetPlatform}");

    // return "localhost:8000";

    if ((defaultTargetPlatform == TargetPlatform.iOS) ||
        (defaultTargetPlatform == TargetPlatform.android)) {
      // Some android/ios specific code
      return const String.fromEnvironment("API_URL",
          defaultValue: "me-maintenance-backend.herokuapp.com");
    } else if ((defaultTargetPlatform == TargetPlatform.linux) ||
        (defaultTargetPlatform == TargetPlatform.macOS) ||
        (defaultTargetPlatform == TargetPlatform.windows)) {
      // Some desktop specific code there
      return const String.fromEnvironment("API_URL",
          defaultValue: "me-maintenance-backend.herokuapp.com");
      return "http://localhost:8000";
    } else {
      // Some web specific code there
      return const String.fromEnvironment("API_URL",
          defaultValue: "me-maintenance-backend.herokuapp.com");
    }
    print("Returning dummy API value - so it will be WRONG");
    return _apiUrl;
  }
}
