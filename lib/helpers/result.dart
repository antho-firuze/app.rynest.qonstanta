class Result<T> {
  bool status;
  String? message;
  String? errCode;
  T? data;

  Result.success({this.message, this.errCode, this.data}) : status = true;
  Result.warning({this.message, this.errCode, this.data}) : status = true;
  Result.error({this.message, this.errCode, this.data}) : status = false;
}
