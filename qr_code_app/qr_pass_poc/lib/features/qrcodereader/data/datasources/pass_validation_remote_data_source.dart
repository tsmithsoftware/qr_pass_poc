import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:qr_pass_poc/core/error/exception.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';

abstract class PassValidationRemoteDataSource {
  Future<PassValidationResponseModel> validatePass(Params params);
}

class PassValidationRemoteDataSourceImpl extends PassValidationRemoteDataSource {
  final http.Client client;

  PassValidationRemoteDataSourceImpl({@required this.client});
  @override
  Future<PassValidationResponseModel> validatePass(Params params) async {
    final response = await client.post(
        "http://192.168.0.5:8080/validate",
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.toString()
        },
      body: jsonEncode(params.pass.toJson())
        );

    if(response.statusCode == 200) {
      return PassValidationResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(response.statusCode, response.body);
    }
  }

}