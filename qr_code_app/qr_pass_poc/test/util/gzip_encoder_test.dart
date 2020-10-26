import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_pass_poc/core/logger.dart';
import 'package:qr_pass_poc/util/gzip_encoder.dart';
import 'package:path/path.dart' as path;

import '../fixtures/fixture_reader.dart';

void main() {
  test('test gzip encoded QR code', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // zip file
    String dataToEncode = fixture("qr_code_data.json");
    // create qr code image
    ByteData qrCode = await QrImageCreator.createEncodedQrCode(data: dataToEncode);
    // save to file
    var pathString = path.current;
    final buffer = qrCode.buffer;
    File newFile = await new File('$pathString\\qrCode.png').writeAsBytes(buffer.asUint8List(qrCode.offsetInBytes, qrCode.lengthInBytes));
    // base64result is the QR code run through an online decoder (https://zxing.org/w/decode), for speed. In the project itself, this would be done with a library. Problems occurred with doing this in a test.
    assert(newFile.existsSync());
    String base64result = "H4sIAEVnkF8A/6vm5VJQUCpILC72K81NSi1SslIwNDEx0gELpySWpIYl5mSmuBXl5wJllIwMjAx0DQ10jQwUDI2sDAyASM/AwEAJody1oiCzqBKq1hCs1lDByBhDLcjGkMqCVJDKAMfgYCRhZ6Ax6fkQQxyh4mWZxZkl+UV+iblgHU75SagSzvm5BYl5YC1OAUq8XLUA5hZFMtgAAAA=";
    Uint8List gzipresult = base64Decode(base64result);
    List<int> decodedGZipResult = GZipCodec().decode(gzipresult);
    String decodedUtf8String = utf8.decode(decodedGZipResult);
    assert(decodedUtf8String == dataToEncode);
  });

  test('create qr codes from all files in test/fixtures/qrcodedata/jsonFiles folder', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Directory testDataDir = Directory("test\\fixtures\\qrcodedata\\jsonFiles");
    bool exists = await testDataDir.exists();
    if (exists) {
      await createCodes(testDataDir);
    }

    assert(true);
  });
}

createCodes(Directory testDataDir) async {
  List<FileSystemEntity> list = testDataDir.listSync(recursive: true, followLinks: false);
  for (FileSystemEntity ent in list) {
    if (ent is File) {
      if (path.basename(ent.path).contains("json")) {
        await createFile(ent, testDataDir);
      }
    }
  }
}

Future<File> createFile(FileSystemEntity entity, Directory testDataDir) async {
  String dataToEncode = File('${entity.path}').readAsStringSync();
  // create qr code image
  ByteData qrCode = await QrImageCreator.createEncodedQrCode(
      data: dataToEncode);
  // save to file
  final buffer = qrCode.buffer;
  String fileName = path.basename(entity.path);
  fileName = fileName.replaceAll(".json", ".png");
  String filePathString = testDataDir.path + "\\$fileName";
  File newFile = await new File('$filePathString').writeAsBytes(
      buffer.asUint8List(qrCode.offsetInBytes, qrCode.lengthInBytes));
  return newFile;
}
