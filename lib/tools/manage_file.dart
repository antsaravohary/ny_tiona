import 'dart:io';
import 'package:flutter/services.dart';

// Copier un fichier dans le projet vers le système
Future<bool> copyFileInRootBundleToSystemFile(
    String source, String destination) async {
  try {
    ByteData data = await rootBundle.load(source);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(destination).writeAsBytes(bytes, flush: true);
    return Future.value(true);
  } catch (e) {
    rethrow;
  }
}
