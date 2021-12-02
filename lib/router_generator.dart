import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/home/home_page.dart';
import 'package:me_maintanence/patient/patient.dart' as pt;
import 'package:me_maintanence/recommendations/preventative_care_screen.dart';
import 'package:me_maintanence/recommendations/recommendation.dart';
import 'package:me_maintanence/recommendations/recommendations_context.dart';
import 'package:me_maintanence/user/user_login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => UserLogin());

      case '/preventative-care':
        final args = settings.arguments as RecommendationsContext;
        return MaterialPageRoute(builder: (_) => PreventativeCareScreen(
          rctx: args,
        ));

      case '/home':
        final args = settings.arguments as pt.Patient;

        return MaterialPageRoute(
            builder: (_) => HomePage(
                  patient: args,
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
