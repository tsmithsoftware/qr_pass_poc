import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_pass_poc/main.dart';

import '../../../../base_injection_container.dart';
/**
const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class QrScanPage extends StatefulWidget {
  const QrScanPage({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  var qrText = '';
  var flashState = flashOn;
  var cameraState = frontCamera;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl<GetPassBloc>(),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                        'Please sign in the visitor by scanning a BP Digital Pass QR code'),
                    Text('How to scan an official BP Digital Pass QR code'),
                    Text(
                        'Hold the tablet so that the BP Digital Pass QR code appears in the box above. When your tablet recognises the QR code, you will be returned to the Visitor Sign In Screen with the pass information included.'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        BlocProvider(
                            create: (_) => sl<GetPassBloc>(),
                            child: Column(
                              children: [
                                BlocBuilder<GetPassBloc, GetPassState>(
                                  builder: (context, state) {
                                    print(
                                        "In build body listening for GetPassState => $state");
                                    if (state is GetPassInitial) {
                                      return Container();
                                    } else if (state is GetPassError) {
                                      return Container(
                                          child: Text(
                                              "Error! ${state.failure.message}"));
                                    } else if (state is GetPassLoading) {
                                      return LoadingIndicator();
                                    } else if (state is GetPassLoaded) {
                                      Get.to(QrPassPoc());
                                      return Container();
                                    } else
                                      return Container(
                                        child: Column(
                                          children: [Text("No GetPassState!")],
                                        ),
                                      );
                                  },
                                ),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _isFlashOn(String current) {
    return flashOn == current;
  }

  bool _isBackCamera(String current) {
    return backCamera == current;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        // make call here
        dynamic gzipEncodedData = base64Decode(scanData);
        List<int> decodedGZipResult = GZipCodec().decode(gzipEncodedData);
        String decodedUtf8String = utf8.decode(decodedGZipResult);
        Map<String, dynamic> dataAsJson = json.decode(decodedUtf8String);
        try {
          QrPassModel model = QrPassModel.fromJson(dataAsJson);
          if (validateQrPassModel(model)) {
            addPassBloc(context, model); // Bloc will check local storage if necessary
          } else {
            displayError("Pass not valid! Please sign in the visitor manually.");
          }
        } catch (e) {
          displayError("Error! Please sign in the visitor manually.");
        }
      });
    });
  }

  void displayError(String message) {
    Get.defaultDialog(
        title: "Error!",
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(message)
            ],
          ),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool validateQrPassModel(QrPassModel model) {
    DateTime validFrom = DateTime.parse(model.dateValidFrom);
    DateTime validTo = DateTime.parse(model.dateExpiry);
    DateTime now = DateTime.now();
    bool validFromCheck = validFrom.isBefore(now);
    bool validToCheck = validTo.isAfter(now);
    return (validFromCheck && validToCheck);
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white),
      ),
    );
  }
}

void addPassBloc(BuildContext context, QrPassModel model) =>
    BlocProvider.of<GetPassBloc>(context).add(GetConcretePass(model));

    **/