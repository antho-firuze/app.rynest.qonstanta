import 'package:qonstanta/api/api_service.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:qonstanta/services/database_service.dart';
import 'package:qonstanta/services/fcm_service.dart';
import 'package:qonstanta/ui/views/auth/signin_view.dart';
import 'package:qonstanta/ui/views/dashboard/dashboard2_view.dart';
import 'package:qonstanta/ui/views/dashboard/dashboard_view.dart';
import 'package:stacked/stacked.dart';

class StartUpViewModel extends FutureViewModel {
  String _title = 'Startup';
  String get title => _title;

  final _api = locator<ApiService>();
  final _db = locator<DatabaseService>();
  // final _notif = locator<NotificationService>();
  final _pusher = locator<FcmService>();

  @override
  Future futureToRun() async {
    print(_title);

    await F.wait(seconds: 2);

    // Init Database
    await _db.initialise();

    // await _pusher.listen();
    await _pusher.subs.signIn();

    // Init Notification
    // await _notif.initialise();

    await isFirstRun();
    // await checkToken();
    await checkIsLogin();

    // await F.navigateWithTransition(SigninView());
    await F.replaceWithTransition(DashboardView());
  }

  Future isFirstRun() async {
    bool isFirstRun = await F.session.isFirstRun();
    if (isFirstRun) {
      await F.session.isFirstRun(value: false);
    }
  }

  Future checkToken() async {
    String _token = await F.session.token();
    if (_token.isNotEmpty) {
      Result _result = await _api.checkToken();

      if (!_result.status) {
        await F.showErrorDialog(_result.message!);

        if (_result.errCode == '9000') {
          await F.session.token(value: '');
        }

        if (_result.errCode == '999999999')
          return await F.onNetworkError(callback: checkToken);

        await F.navigateWithTransition(SigninView());
      }
    } else {
      await F.navigateWithTransition(SigninView());
    }
  }

  Future checkIsLogin() async {
    String _token = await F.session.token();
    if (_token.isEmpty) return await F.navigateWithTransition(SigninView());
  }
}
