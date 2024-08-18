import 'package:dio/dio.dart';
import 'package:qonstanta/helpers/F.dart';

class ApiRequest {
  String? id;
  String? lang;
  String? agent;
  String? method;
  String? token;
  dynamic filePath;
  dynamic params;

  ApiRequest({
    this.id,
    this.lang,
    this.agent,
    this.method,
    this.token,
    this.filePath,
    this.params,
  });

  Future<Map<String, dynamic>> toJson() async => {
        "id": id ?? F.rndNum().toString(),
        "lang": lang ?? await F.session.lang(),
        "agent": agent ?? F.agent,
        "method": method,
        "token": token ?? await F.session.token(),
        "params": params,
        "userfile":
            filePath == null ? null : await MultipartFile.fromFile(filePath)
      };

  Future<Map<String, dynamic>> print() async => {
        "id": id ?? F.rndNum().toString(),
        "lang": lang ?? await F.session.lang(),
        "agent": agent ?? F.agent,
        "method": method,
        "token": token ?? await F.session.token(),
        "params": params,
      };
}
