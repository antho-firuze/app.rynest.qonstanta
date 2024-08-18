class ApiResponse {
  String? id;
  bool? status;
  String? message;
  dynamic data;
  ApiError? error;

  ApiResponse({this.id, this.status, this.message, this.data, this.error});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    status = json['status'] ?? false;
    message = json['message'] ?? '';
    data = json['result'] ?? null;
    error = json['error'] == null ? null : ApiError.fromJson(json['error']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "message": message,
        "data": data,
        "error": error == null ? null : error!.toJson(),
      };
}

class ApiError {
  String? message;
  String? code;
  ApiError({this.message, this.code});

  ApiError init() => ApiError(message: '', code: '');

  ApiError.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    code = json['code'].toString();
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
      };
}
