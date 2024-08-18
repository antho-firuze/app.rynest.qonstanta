import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart' as g;
import 'package:qonstanta/constants/firebase_config.dart';

import 'F.dart';
import 'result.dart';

class FcmHelper {
  final Logger? _log = Logger();

  static BaseOptions _dioOptions = BaseOptions(
    connectTimeout: connTimeout,
    receiveTimeout: recvTimeout,
  );

  Dio _dio = new Dio(_dioOptions);

  Future send(dynamic payload) async {
    try {
      _log?.d(payload);

      var options = Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      });

      // Set Busy to True
      // Don't use await
      F.setBuzy(true);

      Response _response =
          await _dio.post(fcmNode, data: payload, options: options);

      // Set Busy to False
      await F.setBuzy(false);

      // Trapping Error from external factor #1 (HTTP ERROR)
      if (_response.statusCode != 200) {
        _log?.e("Error: ${_handleErrorReq(_response.statusCode)} "
            "(${_response.statusCode})");

        return Result.error(
            message: _handleErrorReq(_response.statusCode),
            errCode: _response.statusCode.toString());
      }

      // RESPONSE SUCCESS
      _log?.d(_response);
      return Result.success(
          data: _response.data, message: _response.statusMessage);
    } catch (e) {
      _log?.e("Error: ${_handleErrorReq(e)} (999999999)");
      // Trapping Error from external factor #2 (NETWORK ERROR)
      return Result.error(message: _handleErrorReq(e), errCode: '999999999');
    }
  }

  // Error handle request
  String _handleErrorReq(dynamic error) {
    String errorDescription = "";
    if (error is int) {
      switch (error) {
        case 400:
          errorDescription = "400 Bad Request";
          break;
        case 401:
          errorDescription = "401 Unauthorized";
          break;
        case 403:
          errorDescription = "403 Forbidden";
          break;
        case 404:
          errorDescription = "404 Not Found";
          break;
        case 500:
          errorDescription = "500 Internal Server Error";
          break;
        case 502:
          errorDescription = "502 Bad Gateway";
          break;
        case 503:
          errorDescription = "503 Service Unavailable";
          break;
        case 504:
          errorDescription = "504 Gateway Timeout";
          break;
        default:
          errorDescription = "$error Unexpected error occured";
      }
    } else if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "error_api_cancel".tr;
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "error_api_conntimeout".tr;
          break;
        case DioErrorType.other:
          errorDescription = "error_api_other".tr;
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "error_api_recvtimeout".tr;
          break;
        case DioErrorType.response:
          errorDescription = "error_api_response"
              .trArgs([error.response!.statusCode.toString()]);
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "error_api_sendtimeout".tr;
          break;
      }
    } else {
      errorDescription = error.message;
    }
    return errorDescription;
  }
}

final fcmHelper = FcmHelper();
