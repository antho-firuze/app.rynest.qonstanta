import 'package:qonstanta/api/api_method.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/helpers/firebase_auth_helper.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:qonstanta/helpers/api_helper.dart';
import 'package:qonstanta/models/api_request.dart';
import 'package:get/get.dart';

class ApiService {
  int? otp;
  String? otpEmail;
  String? fullName;
  bool isRegister = false;

  Future checkToken() async {
    ApiRequest payload = ApiRequest(method: apiMethod.auth.checkToken);

    Result _result = await apiHelper.post(payload);

    if (_result.status) {
      return Result.success(data: _result.data, message: _result.message);
    } else {
      if (_result.errCode == "9000") _result.message = "Invalid token".tr;
      return Result.error(message: _result.message, errCode: _result.errCode);
    }
  }

  Future signUp({
    required String username,
    required String password,
  }) async {
    // ApiRequest payload = ApiRequest(
    //   method: apiMethod.auth.register,
    //   params: {
    //     'username': username,
    //     'password': password,
    //     'fullname': fullname,
    //     'phone': phone,
    //   },
    // );
    // Result _result = await apiHelper.post(payload);

    F.setBuzy(true);
    Result _result = await firebaseAuthHelper.signUpWithEmail(
        email: username, password: password);
    await F.setBuzy(false);

    if (_result.status) {
      return Result.success(data: _result.data, message: 'success_signup'.tr);
    } else {
      return Result.error(message: _result.message, errCode: _result.errCode);
    }
  }

  Future signIn({
    required String username,
    required String password,
  }) async {
    ApiRequest payload = ApiRequest(
      method: apiMethod.auth.login,
      params: {
        "username": username,
        "password": password,
      },
    );
    Result _result = await apiHelper.post(payload);

    // Result _result = await firebaseAuthHelper.signInWithEmail(
    //     email: username, password: password);

    if (_result.status) {
      return Result.success(data: _result.data['token'], message: 'success_signin'.tr);
    } else {
      return Result.error(message: _result.message, errCode: _result.errCode);
    }
  }

  Future signInWithGoogle({
    required String username,
    required String googleID,
    String? fullname,
  }) async {
    // ApiRequest payload = ApiRequest(
    //   method: apiMethod.auth.loginWithGoogle,
    //   params: {
    //     'username': username,
    //     'google_id': googleID,
    //     'fullname': fullname ?? '',
    //     'dt_client': F.currDate,
    //   },
    // );

    // Result _result = await apiHelper.post(payload);

    Result _result = await firebaseAuthHelper.signInWithGoogle();
    if (_result.status) {
      return Result.success(data: _result.data, message: _result.message);
    } else {
      return Result.error(message: _result.message, errCode: _result.errCode);
    }
  }

  Future signInWithApple({
    required String username,
    required String appleID,
    String? fullname,
  }) async {
    ApiRequest payload = ApiRequest(
      method: apiMethod.auth.loginWithApple,
      params: {
        'username': username,
        'apple_id': appleID,
        'fullname': fullname ?? '',
        'dt_client': F.currDate,
      },
    );

    Result _result = await apiHelper.post(payload);

    if (_result.status) {
      return Result.success(data: _result.data, message: _result.message);
    } else {
      return Result.error(message: _result.message, errCode: _result.errCode);
    }
  }

  Future signOut({
    required String username,
    required String password,
  }) async {
    Result _result = await firebaseAuthHelper.signOut();

    if (_result.status) {
      return Result.success();
    } else {
      return Result.error();
    }
  }

  Future sendOTP(
      {required String email, String? fullname, String? promotionCode}) async {
    ApiRequest payload = ApiRequest(method: apiMethod.auth.sendOTP, params: {
      "email": email,
      "fullname": fullname,
      "promotion_code": promotionCode,
    });

    Result _result = await apiHelper.post(payload);

    if (_result.status) {
      isRegister = true;
      otpEmail = email;
      fullName = fullname;
      otp = _result.data['otp'] is String
          ? int.parse(_result.data['otp'])
          : _result.data['otp'];
      return Result.success(data: otp, message: _result.message);
    } else {
      return Result.error(message: _result.message, errCode: _result.errCode);
    }
  }

  Future changePassword(
      {required String password, required String newPassword}) async {
    ApiRequest payload =
        ApiRequest(method: apiMethod.auth.passwordChange, params: {
      'password': password,
      'new_password': newPassword,
    });

    Result _result = await apiHelper.post(payload);

    if (_result.status) {
      return Result.success(data: _result.data, message: _result.message);
    } else {
      return Result.error(message: _result.message, errCode: _result.errCode);
    }
  }

  Future forgotPassword({required String email}) async {
    ApiRequest payload =
        ApiRequest(method: apiMethod.auth.passwordForgot, params: {
      "email": email,
    });

    Result _result = await apiHelper.post(payload);

    if (_result.status) {
      otpEmail = email;
      otp = _result.data['otp'] is String
          ? int.parse(_result.data['otp'])
          : _result.data['otp'];
      return Result.success(data: otp, message: _result.message);
    } else {
      return Result.error(message: _result.message, errCode: _result.errCode);
    }
  }

  Future resetPassword({required int otp, required String password}) async {
    ApiRequest payload =
        ApiRequest(method: apiMethod.auth.passwordReset, params: {
      'otp': otp,
      'password': password,
    });

    Result _result = await apiHelper.post(payload);

    if (_result.status) {
      return Result.success(data: _result.data, message: _result.message);
    } else {
      return Result.error(message: _result.message, errCode: _result.errCode);
    }
  }
}
