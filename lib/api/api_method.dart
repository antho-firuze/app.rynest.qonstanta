class ApiMethod {
  _App app = _App();
  _Auth auth = _Auth();
}

class _App {
  String getBanner = 'app.get_banner';
}

class _Auth {
  String checkToken = 'auth.check_token';
  String login = 'auth.login';
  String loginWithGoogle = 'auth.login_with_google_id';
  String loginWithApple = 'auth.login_with_apple_id';
  String register = 'auth.register';
  String sendOTP = 'auth.send_otp';
  String passwordChange = 'auth.password_change';
  String passwordForgot = 'auth.password_forgot';
  String passwordReset = 'auth.password_reset';
}

final apiMethod = ApiMethod();
