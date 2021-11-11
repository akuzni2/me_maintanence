// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_maintanence/patient/patient.dart' as pt;
import 'package:me_maintanence/patient/patient_service.dart';
import 'package:me_maintanence/user/user.dart';
import 'package:me_maintanence/user/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_credentials.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  late LoginInfo loginInfo;
  late User user;
  late pt.Patient patient;
  final PatientService patientService = MyPatientService();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Text("Maintanence for ME",
                      style: TextStyle(
                          color: Colors.black, fontSize: 40 * textScale)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0, bottom: 50),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 0, bottom: 0),
                  // padding: EdgeInsets.all(15),
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          hintText: 'Enter Provider given username'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: 300,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter provider given password'),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.all(10)),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      _handleLogin();
                    },
                    style: TextButton.styleFrom(primary: Colors.deepOrange),
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 130,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    print("Handling Login. ");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    loginInfo = LoginInfo(userNameController.text, passwordController.text);

    // Set when access for the first time
    if (!prefs.containsKey("isLoggedIn")) {
      prefs.setBool("isLoggedIn", false);
    }

    var loggedIn = prefs.getBool("isLoggedIn");

    if (loggedIn != null) {
      if (loggedIn) {
        Navigator.of(context).pushNamed("/home", arguments: patient);
      } else {
        print("Do Login here");

        try {
          user = await _isCredentialValid(loginInfo);
          patient = await patientService.getPatient(user);
          Navigator.of(context).pushNamed("/home", arguments: patient);
        } catch (e) {
          print(e);
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildErrorPopupDialog(context),
          );
        }
      }
    }
  }

  Future<User> _isCredentialValid(LoginInfo loginInfo) async {
    UserService userService = UserService();
    print("hi");
    var validUser = await userService.isValidCredential(loginInfo);
    print("okay");
    return validUser;
  }

  Widget _buildErrorPopupDialog(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Provided username & password combination is incorrect."),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
