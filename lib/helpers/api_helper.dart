import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:qonstanta/constants/api_config.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:qonstanta/models/api_request.dart';
import 'package:qonstanta/models/api_response.dart';
import 'package:get/get.dart' as g;

import 'F.dart';

// import 'F.dart';

class ApiHelper {
  final Logger? log = Logger();

  // For DIO package =====================================
  static BaseOptions _dioOptions = new BaseOptions(
    baseUrl: endPointUrl,
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout,
  );
  Dio _dio = new Dio(_dioOptions);
  Future _dioPost(dynamic payload) async => await _dio.post('', data: payload);

  // For http package =====================================
  // Map<String, String> header = {'Content-Type': 'application/json'};
  // Future _httpPost(Map<String, dynamic> payload) async => await http
  //     .post(Uri.parse(endPointUrl), headers: header, body: jsonEncode(payload));

  // For HttpClient
  // final client = HttpClient();
  // Future post2(Map<String, dynamic> data) async {
  //   client.connectionTimeout = const Duration(seconds: 5);
  //   try {
  //     final request = await client.postUrl(Uri.parse(endPointUrl));
  //     request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
  //     request.write(data);

  //     final response = await request.close();
  //     response.transform(utf8.decoder).listen((content) {
  //       return content;
  //     });
  //   } catch (e) {}
  // }

  // For Handle HTTP POST REQUEST
  Future<Result> post(ApiRequest payload) async {
    try {
      var _payload = FormData.fromMap(await payload.toJson());
      log?.d(await payload.print());

      // Set Busy to True
      // Don't use await
      F.setBuzy(true);

      // Make REQUEST to endpoint API
      Response _response = await _dioPost(_payload);

      // Set Busy to False
      await F.setBuzy(false);

      // Trapping Error from external factor #1 (HTTP ERROR)
      if (_response.statusCode != 200) {
        log?.e("Error: ${_handleErrorReq(_response.statusCode)} "
            "(${_response.statusCode})");

        return Result.error(
            message: _handleErrorReq(_response.statusCode),
            errCode: _response.statusCode.toString());
      }

      ApiResponse _resp = ApiResponse.fromJson(_response.data);
      log?.d(_resp.toJson());

      // Trapping Error from internal factor
      if (!_resp.status!) {
        return Result.error(
          message: _resp.error!.message,
          errCode: _resp.error!.code,
        );
      }

      // RESPONSE SUCCESS
      return Result.success(data: _resp.data, message: _resp.message);
    } catch (e) {
      log?.e("Error: ${_handleErrorReq(e)} (999999999)");
      // Trapping Error from external factor #2 (NETWORK ERROR)
      return Result.error(message: _handleErrorReq(e), errCode: '999999999');
    }
  }

  // For Handle Response data from dio or http
  // Map<String, dynamic> _responseData(dynamic response) =>
  //     response is http.Response
  //         ? jsonDecode(response.body)
  //         : response is Response
  //             ? response.data
  //             : {};

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

final apiHelper = ApiHelper();
