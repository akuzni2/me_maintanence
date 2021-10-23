import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/patient/login_credentials.dart';

class HomePage extends StatelessWidget {
  final LoginInfo loginInfo;

  HomePage({
    Key? key,
    required this.loginInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text("hi. Here is username: " + (loginInfo.username ?? ""),
              style: TextStyle(color: Colors.black, fontSize: 24))),
    );
  }
}
