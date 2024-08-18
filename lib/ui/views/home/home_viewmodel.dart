import 'package:flutter/material.dart';
import 'package:qonstanta/api/api_app.dart';
import 'package:qonstanta/app/app.locator.dart';
import 'package:qonstanta/helpers/F.dart';
import 'package:qonstanta/helpers/result.dart';
import 'package:qonstanta/models/app_banner.dart';
import 'package:qonstanta/ui/views/video/video_view.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends FutureViewModel {
  String _title = 'Dashboard';
  String get title => _title;

  final _apiApp = locator<ApiApp>();

  List<AppBanner>? appBanners;
  // List<String> imgList = [];
  List<String> imgList2 = [];
  List<String> imgList3 = [];

  @override
  Future futureToRun() async {
    debugPrint(_title);

    await getBanner();

    // imgList = [
    //   'https://qonstanta.com/images/banner-qonstanta-01.png',
    //   'https://qonstanta.com/images/banner-qonstanta-02.png',
    //   'https://qonstanta.com/images/banner-qonstanta-03.png',
    //   'https://qonstanta.com/images/banner-qonstanta-04.png',
    //   'https://qonstanta.com/images/banner-qonstanta-05.png',
    // ];

    imgList2 = [
      'https://picsum.photos/id/1015/400/300',
      'https://picsum.photos/id/1005/400/300',
      'https://picsum.photos/id/1003/400/300',
      'https://picsum.photos/id/0/400/300',
      'https://picsum.photos/id/1036/400/300',
    ];

    imgList3 = [
      'https://picsum.photos/id/1035/400/300',
      'https://picsum.photos/id/1033/400/300',
      'https://picsum.photos/id/103/400/300',
      'https://picsum.photos/id/1031/400/300',
      'https://picsum.photos/id/1042/400/300',
    ];

    notifyListeners();
  }

  Future getBanner() async {
    Result _result = await _apiApp.getBanner();
    if (!_result.status)
      return await F.onApiRequestError(result: _result, callback: getBanner);

    appBanners = _result.data;
    notifyListeners();
  }

  // Future getPrayerTime() async {
  //   if (isPrayerLoading) return;

  //   isPrayerLoading = true;
  //   prayerTime = await _adhan.getPrayerTime(gps);
  //   currPrayer = prayerTime.currentPrayer();
  //   address = await _gps.getAddress(gps);
  //   // print(address.subAdminArea);
  //   isPrayerLoading = false;
  //   notifyListeners();
  // }

  showMenu(int menuId) async {
    if (isBusy) return;

    await F.showInfoDialog('menu-$menuId');
    // await F.navigateWithTransition(VideoView());

    switch (menuId) {
      case 1:
        if (isBusy) return;
        // await F.navigateWithTransition(AboutView());

        break;
      case 2:
        if (isBusy) return;
        // await F.navigateWithTransition(MqttView());

        break;
    }
  }

  learningVideo() async => await F.navigateWithTransition(VideoView());
}
