import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:me_maintanence/user/user.dart';
import 'package:me_maintanence/config/app_config.dart';

import 'login_credentials.dart';

class UserService {
  var conf = AppConfig();

  Future<User> getUser(String username, String password) async {
    String baseUri = conf.getApiUrl();
    String fullUri = baseUri + "/api/login";
    print("Calling api url [$baseUri]");

    Map<String, String> headers = {
      "content-type": "application/json",
      "username": username,
      "password": password
    };

    final response = await http.get(Uri.parse(fullUri), headers: headers);

    print("Got response from api: ${response.body}");
    print("Got response code from api: ${response.statusCode}");

    var user = User.fromJsonString(response.body);

    print("got user ${user.password}");

    return user;
  }

  Future<User> isValidCredential(LoginInfo loginInfo) async {
    print("getting user");
    String? username = loginInfo.username;
    String? password = loginInfo.password;

    if (username != null && password != null) {
      User user = await getUser(username, password);

      if (password == user.password) {
        return user;
      }
      throw ClientException("Invalid credentials");
    }

    throw ClientException("Something went wrong");
  }
}
