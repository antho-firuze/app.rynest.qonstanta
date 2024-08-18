import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qonstanta/ui/shared/ui_helper.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageView extends StatelessWidget {
  final dynamic image;

  const ImageView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            InteractiveViewer(
              panEnabled: false, // Set it to false
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 2,
              child: (image is String)
                  ? (image.substring(0, 4).toLowerCase() == 'http')
                      ? imageNetwork()
                      : imageEncoder()
                  : imageFile(),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget imageNetwork() {
    return Container(
      child: FadeInImage.memoryNetwork(
        width: screenWidth,
        height: screenHeight,
        fit: BoxFit.contain,
        placeholder: kTransparentImage,
        image: image,
        imageErrorBuilder: (context, error, stackTrace) => Container(),
      ),
    );
  }

  Widget imageFile() {
    return ClipOval(
      child: Image.file(
        image!,
        width: screenWidth,
        height: screenHeight,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget imageEncoder() {
    Uint8List bytes = base64.decode(image);
    return ClipOval(
      child: Image.memory(
        bytes,
        width: screenWidth,
        height: screenHeight,
        fit: BoxFit.contain,
      ),
    );
  }
}
