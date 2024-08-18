import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MediaService {
  Future dialogImageSelector({
    BuildContext? ctx,
    required Future callback(File pickedImage),
    bool withCrop = true,
  }) async =>
      showDialog(
        context: ctx!,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("Pick from Gallery"),
                onTap: () async {
                  File? _pickedImage =
                      await loadPicker(ImageSource.gallery, withCrop: withCrop);
                  if (_pickedImage != null) {
                    await callback(_pickedImage);
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Take a Picture"),
                onTap: () async {
                  File? _pickedImage =
                      await loadPicker(ImageSource.camera, withCrop: withCrop);
                  if (_pickedImage != null) {
                    await callback(_pickedImage);
                  }
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      );

  Future getImage({bool fromGallery = true}) {
    return ImagePicker().pickImage(
      maxWidth: 720,
      maxHeight: 960,
      imageQuality: 50,
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
    );
  }

  Future loadPicker(ImageSource source, {bool withCrop = true}) async {
    var _selectedImage = await ImagePicker().pickImage(
      maxWidth: 720,
      maxHeight: 960,
      imageQuality: 50,
      source: source,
    );
    if (_selectedImage != null) {
      File picked = File(_selectedImage.path);

      if (withCrop)
        return await _cropImage(picked);
      else
        return picked;
    }
    return null;
  }

  Future _cropImage(File picked) async {
    File? cropped = await ImageCropper.cropImage(
        androidUiSettings: AndroidUiSettings(
          statusBarColor: Colors.red,
          toolbarColor: Colors.red,
          toolbarTitle: "Crop Image",
          toolbarWidgetColor: Colors.white,
        ),
        sourcePath: picked.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio16x9,
          CropAspectRatioPreset.ratio4x3,
        ],
        maxWidth: 800,
        cropStyle: CropStyle.circle);
    return cropped;
  }
}
