import 'dart:async';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class VideoPlayerz extends StatefulWidget {
  VideoPlayerz({Key? key, required this.dataSource}) : super(key: key);

  final String dataSource;

  @override
  _VideoPlayerzState createState() => _VideoPlayerzState();
}

class _VideoPlayerzState extends State<VideoPlayerz> {
  VideoPlayerController? _controller;
  bool showNavigator = false, isEnd = false;
  StreamSubscription? _subscription;
  Orientation? target;
  bool isPortrait = true, isFullScreen = false, isPortraitPhysic = true;

  @override
  void didChangeDependencies() async {
    // print('didChangeDependencies');
    final _orientation = await NativeDeviceOrientationCommunicator()
        .orientation(useSensor: true);
    // print(_orientation);
    final _isPortrait = _orientation == NativeDeviceOrientation.portraitUp;
    final _isLandscape =
        _orientation == NativeDeviceOrientation.landscapeLeft ||
            _orientation == NativeDeviceOrientation.landscapeRight;
    final _isTargetPortrait = target == Orientation.portrait;
    final _isTargetLandscape = target == Orientation.landscape;

    // print('_isPortrait = $_isPortrait');
    // print('_isLandscape = $_isLandscape');
    // print('_isTargetPortrait = $_isTargetPortrait');
    // print('_isTargetLandscape = $_isTargetLandscape');

    if (_isLandscape == _isTargetLandscape ||
        _isPortrait == _isTargetPortrait) {
      // print('_isLandscape == _isTargetLandscape');
      target = null;
      AutoOrientation.fullAutoMode();
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.dataSource)
      ..addListener(() => setState(() {}))
      ..initialize().then((_) => setState(() {}));

    _subscription = NativeDeviceOrientationCommunicator()
        .onOrientationChanged(useSensor: true)
        .listen((event) {
      didChangeDependencies();
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    _subscription!.cancel();
    super.dispose();
  }

  String getDuration() {
    final duration =
        Duration(milliseconds: _controller!.value.duration.inMilliseconds);

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  String getPosition() {
    final duration = Duration(
        milliseconds: _controller!.value.position.inMilliseconds.round());

    if (_controller!.value.position.inMilliseconds >=
            _controller!.value.duration.inMilliseconds - 1 &&
        !isEnd) {
      isEnd = true;
      showNavigator = true;
      // _controller!.pause();
    }

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  void setOrientation(bool isPortrait) {
    if (isPortrait) {
      Wakelock.disable();
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    } else {
      Wakelock.enable();
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return OrientationBuilder(builder: (context, orientation) {
      isPortrait = orientation == Orientation.portrait;

      setOrientation(isPortrait);

      return WillPopScope(
        onWillPop: () async {
          if (!isPortrait) {
            AutoOrientation.portraitUpMode();
            await Future.delayed(Duration(seconds: 2));
            AutoOrientation.fullAutoMode();
            return Future.value(false);
          }
          return true;
        },
        child: GestureDetector(
          onTap: () {
            showNavigator = !showNavigator;

            (context as Element).markNeedsBuild();
          },
          child: SafeArea(
            child: AspectRatio(
              aspectRatio: !isPortrait
                  ? deviceRatio
                  : _controller!.value.isInitialized
                      ? _controller!.value.aspectRatio
                      : 16.0 / 9.0,
              child: Stack(
                children: [
                  Container(color: oBlack),
                  _controller!.value.isInitialized
                      ? VideoPlayer(_controller!)
                      : Center(child: CircularProgressIndicator()),
                  _controller!.value.isInitialized
                      ? buildNavigator()
                      : Container(),
                  buildDuration(),
                  buildSetting(),
                  buildIndicator(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildDuration() => Positioned(
        bottom: 25,
        left: 20,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: showNavigator ? 1 : 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getPosition(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: oWhite,
                ),
              ),
              Text(
                ' / ',
                style: TextStyle(
                  fontSize: 16.0,
                  color: oWhite,
                ),
              ),
              Text(
                getDuration(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: oWhite,
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildSetting() => Positioned(
        bottom: 0,
        right: 0,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: showNavigator ? 1 : 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0, right: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.settings, color: oWhite, size: 25),
                  onPressed: () {
                    print('setting');
                    AutoOrientation.fullAutoMode();
                  },
                ),
                IconButton(
                  icon: Icon(
                      isPortrait ? Icons.fullscreen : Icons.fullscreen_exit,
                      color: oWhite,
                      size: 25),
                  onPressed: () async {
                    print('fullscreen');
                    target = isPortrait
                        ? Orientation.landscape
                        : Orientation.portrait;

                    if (isPortrait) {
                      AutoOrientation.landscapeRightMode();
                    } else {
                      AutoOrientation.portraitUpMode();
                    }

                    // (context as Element).markNeedsBuild();
                  },
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildIndicator() => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: showNavigator ? 10 : 3,
          child: VideoProgressIndicator(
            _controller!,
            padding: const EdgeInsets.all(0),
            allowScrubbing: true,
          ),
        ),
      );

  Widget buildNavigator() => Positioned.fill(
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: showNavigator ? 1 : 0,
          child: Container(
            color: Color.fromARGB(150, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: TextButton(
                      onPressed: () {
                        _controller!.seekTo(Duration(
                            seconds:
                                _controller!.value.position.inSeconds - 10));
                        showNavigator = false;
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -10,
                            left: 7,
                            child: Text(
                              '-10s',
                              style: TextStyle(fontSize: 16.0, color: oWhite),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Icon(
                            Icons.fast_rewind,
                            color: oWhite,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _controller!.value.isPlaying
                        ? _controller!.pause()
                        : _controller!.play();

                    showNavigator = !showNavigator;
                    isEnd = false;

                    (context as Element).markNeedsBuild();
                  },
                  icon: Icon(_controller!.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow),
                  color: oWhite,
                  iconSize: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: TextButton(
                      onPressed: () {
                        _controller!.seekTo(Duration(
                            seconds:
                                _controller!.value.position.inSeconds + 10));
                        showNavigator = false;
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -10,
                            left: 7,
                            child: Text(
                              '+10s',
                              style: TextStyle(fontSize: 16.0, color: oWhite),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Icon(
                            Icons.fast_forward,
                            color: oWhite,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
