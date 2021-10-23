import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/home/home_page.dart';
import 'package:me_maintanence/patient/login_credentials.dart';
import 'package:me_maintanence/patient/patient_login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => PatientLogin());

      case '/home':
        final args = settings.arguments as LoginInfo;

        return MaterialPageRoute(
            builder: (_) => HomePage(
                  loginInfo: args,
                ));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
