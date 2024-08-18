
import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:qonstanta/ui/views/widgets/video_playerz.dart';
import 'package:stacked/stacked.dart';

import 'video_viewmodel.dart';

VideoViewModel? _model;

class VideoView extends StatelessWidget {
  const VideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoViewModel>.reactive(
        onModelReady: (model) async {
          _model = model;
        },
        builder: (context, model, child) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(children: [bg, content])),
        viewModelBuilder: () => VideoViewModel());
  }

  get bg => Container(color: primaryColor);

  get content => VideoPlayerz(
        dataSource: _model!.videoSource!,
      );
}

