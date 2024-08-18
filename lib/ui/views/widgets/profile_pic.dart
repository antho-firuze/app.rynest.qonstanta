import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfilePic extends StatelessWidget {
  // final String? imageUrl;
  // final String? imageEnc;
  // final File? imageFile;
  final dynamic image;
  final double? width;
  final double? height;

  const ProfilePic({
    Key? key,
    this.image,
    this.width = 115,
    this.height = 115,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CircleAvatar(
        child: (image is String)
            ? (image.substring(0, 4).toLowerCase() == 'http')
                ? imageNetwork()
                : imageEncoder()
            : imageFile(),
      ),
    );
  }

  Widget imageNetwork() {
    return ClipOval(
      child: FadeInImage.memoryNetwork(
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: kTransparentImage,
        image: image!,
        imageErrorBuilder: (context, error, stackTrace) => Container(),
      ),
    );
  }

  Widget imageFile() {
    return ClipOval(
      child: Image.file(
        image!,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget imageEncoder() {
    Uint8List bytes = base64.decode(image!);
    return ClipOval(
      child: Image.memory(
        bytes,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
