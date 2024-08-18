import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Gg {
  Future<File> writeToFile(Uint8List data, {required String fileName}) async {
    var bytes = ByteData.sublistView(data);
    final buffer = bytes.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/$fileName';
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}

final G = Gg();
