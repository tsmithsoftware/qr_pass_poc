import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:qr_pass_poc/core/error/exception.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/displayed_pass_model.dart';
import 'package:http/http.dart' as http;
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_model.dart';

abstract class DisplayedPassRemoteDataSource {
  Future<DisplayedPassModel> getDisplayedPass(int number);
}

class DisplayedPassRemoteDataSourceImpl implements DisplayedPassRemoteDataSource {
  final http.Client client;

  DisplayedPassRemoteDataSourceImpl({@required this.client});

  @override
  Future<DisplayedPassModel> getDisplayedPass(int number) async {
    try{
      var model = PassValidationModel(passId: number);
      var bodyString = jsonEncode(model.toJson());
      var hdrs = new Map<String, String> ();
      var contentTypeHeader = {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
      };
      hdrs.addAll(contentTypeHeader);

      var result = await client.post(
        'https://voj6te3tx9.execute-api.eu-west-1.amazonaws.com/dev/qrpass',
        body: bodyString,
        headers: hdrs
      ).timeout(Duration(seconds: 10));

      if (result.statusCode == 200) {
        return DisplayedPassModel.fromJson(json.decode(result.body));
      } else {
        throw ServerException();
      }
    } on TimeoutException catch (_) {
      throw ServerException();
    } on SocketException catch(_) {
      throw ServerException();
    }

  }

}