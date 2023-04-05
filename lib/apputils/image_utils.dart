


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';


printFileSize(String path){
  int sizeInBytes = File(path).lengthSync();
  double sizeInMb = sizeInBytes / (1024 * 1024);
  print(sizeInMb);

}

Future<File> getResizedImage(File oFile) async {
  int sizeInBytes = oFile.lengthSync();
  double sizeInMb = sizeInBytes / (1024 * 1024);
  print(sizeInMb);
  if (sizeInMb > 1) {
    oFile = await getResizedImage(await _decreaseSizeAndReturnFile(oFile));
  }
  return oFile;
}

Future<File> _decreaseSizeAndReturnFile(File file) async {
  try {
    final documentsDir = await getApplicationDocumentsDirectory();
    String fileName = '${DateTime.now().microsecond}output.jpg';
    final filepath = '${documentsDir.path}/$fileName';
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      filepath,
      quality: 30,
    );
    if (result != null) {
      return result;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return file;
}

