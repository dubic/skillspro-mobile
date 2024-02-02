import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static Future<XFile?> compressAndGetFile(File file) async {
    print('To compress :: ${file.path}');
    // print('To compress jpeg :: ${file..endsWith('.jpg')}');
    var tempDir = await getTemporaryDirectory();
    var result = await FlutterImageCompress.compressAndGetFile(file.path, tempDir.path);

    print(await file.length());
    print(await result?.length());

    return result;
  }
}
