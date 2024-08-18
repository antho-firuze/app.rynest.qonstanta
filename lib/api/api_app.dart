import 'package:qonstanta/helpers/api_helper.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:qonstanta/models/api_request.dart';
import 'package:qonstanta/models/app_banner.dart';

import 'api_method.dart';

class ApiApp {

  Future getBanner() async {
    ApiRequest payload = ApiRequest(method: apiMethod.app.getBanner);

    Result _result = await apiHelper.post(payload);

    if (_result.status) {
      var _data = AppBanner.fromJsonList(_result.data);
      return Result.success(data: _data, message: _result.message);
    } else {
      return Result.error(message: _result.message, errCode: _result.errCode);
    }
  }
}
