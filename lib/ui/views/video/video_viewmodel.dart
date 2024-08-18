import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class VideoViewModel extends FutureViewModel {
  String _title = 'Video View';
  String get title => _title;

  VideoPlayerController? controller;
  String? videoSource;

  @override
  Future futureToRun() async {
    print(_title);

    videoSource =
        'https://assets.mixkit.co/videos/preview/mixkit-crowds-of-people-cross-a-street-junction-4401-large.mp4';

    // controller = VideoPlayerController.network(video);
    // controller = VideoPlayerController.asset('assets/videos/video1.mp4');
    // await controller!.initialize();
    // await controller!.play();
    // controller = VideoPlayerController.network(video)
    //   ..addListener(() => notifyListeners())
    //   // ..addListener(() => setState(() {}))
    //   ..setLooping(true)
    //   ..initialize().then((_) => controller!.play());

    notifyListeners();
  }

  // @override
  // void dispose() {
  //   controller!.dispose();
  //   super.dispose();
  // }
}
