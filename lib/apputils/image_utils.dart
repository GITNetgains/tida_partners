import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

printFileSize(String path) {
  int sizeInBytes = File(path).lengthSync();
  double sizeInMb = sizeInBytes / (1024 * 1024);
  print(sizeInMb);
}

Future<File> getResizedImage(File oFile) async {
  int sizeInBytes = oFile.lengthSync();
  double sizeInMb = sizeInBytes / (1024 * 1024);
  // print(oFile.lengthSync()/(1024*1024));
  // print(sizeInMb);
  // if (sizeInMb > 1) {
  oFile = await getResizedImage(await _decreaseSizeAndReturnFile(oFile));
  // }
  return oFile;
}

Future<File> _decreaseSizeAndReturnFile(File file) async {
  try {
    final documentsDir = await getApplicationDocumentsDirectory();
    print(documentsDir);
    String fileName = '${DateTime.now().microsecond}output.jpg';
    print(fileName);
    String filepath = '${documentsDir.path}/$fileName';
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      filepath,
      quality: 50,
    );
    // double sizeInMb = file.lengthSync() / (1024 * 1024);
    // print(sizeInMb);
    if (result != null) {
      // print(File(result.path).lengthSync()/(1024*1024));
      return File(result.path);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return file;
}
Future<File> testCompressAndGetFile(File file, String targetPath) async {
  double valu = file.lengthSync()/(1024*1024);
  if ((valu) > 5.0) {
      
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 30,
        rotate: 180,
      );

    
    print(File( result?.path ?? "").lengthSync()/(1024*1024));

    return File( result?.path ?? "");
  }
  if ((valu) > 1.0 && valu < 5.0) {
      
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 50,
        rotate: 180,
      );

    
    print(File( result?.path ?? "").lengthSync()/(1024*1024));

    return File( result?.path ?? "");
  }
  else
  {
    return file;
  }
}