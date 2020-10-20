import 'dart:io';
import 'dart:typed_data';

import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'package:archive/archive.dart';

class QrImageCreator {
  static Future<ByteData> createEncodedQrCode({String data}) async {
    var stringBytes = utf8.encode(data);
    var gzipBytes = GZipEncoder().encode(stringBytes);
    var compressedString = base64.encode(gzipBytes);
    ByteData qrBytes = await QrPainter(data: compressedString, version:  QrVersions.auto).toImageData(439);
    return qrBytes;
  }

  static String decodeEncodedQrCode({String base64Result}) {
    Uint8List gzipresult = base64Decode(base64Result);
    List<int> decodedGZipResult = GZipCodec().decode(gzipresult);
    String decodedUtf8String = utf8.decode(decodedGZipResult);
    return decodedUtf8String;
  }
}