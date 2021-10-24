abstract class LoginService {
  Future<Object> getUser();
  Future<bool> isValidCredentials();
}
