import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_pass_poc/core/logger.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_request_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/presentation/bloc/bloc.dart';
import 'package:qr_pass_poc/main.dart';

import '../../../../base_injection_container.dart';

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
  ValidateQrPassBloc bloc = sl<ValidateQrPassBloc>();
  var qrText = '';
  var flashState = flashOn;
  var cameraState = frontCamera;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  BuildContext _context;
  // may replace with model in validation response
  PassModel _model;

  @override
  Widget build(BuildContext context) {
    _context = context;
    Logger.logDebug(
        "context in qr_scan_page.dart - " + context.hashCode.toString());
    return Scaffold(
      body: BlocProvider<ValidateQrPassBloc>(
        create: (_) => sl<ValidateQrPassBloc>(),
        child: Column(children: [
          getQrCodeScannerView(),
          SizedBox(
              width: 50,
              height: 50,
              child: BlocListener<ValidateQrPassBloc, ValidateQrPassState>(
                cubit: bloc,
                listener: (context, state) {
                  if (state is Empty) {
                    setState(() {
                      qrText = "Empty!";
                    });
                  }
                  if (state is Loading) {
                    setState(() {
                      qrText = "Loading!";
                    });
                  }
                  if (state is Error) {
                    setState(() {
                      qrText = "Error!";
                    });
                  }
                  if (state is Loaded) {
                    setState(() {
                      Get.defaultDialog(
                          title: "Loaded!",
                          content: Column(
                            children: [
                              Text("Please check the below details. If they are acceptaable, please press OK to return to main page and continue with signing in the user."),
                              PassDisplayWidget(model: _model,)
                            ],
                          ),
                          confirm: RaisedButton(
                              child: Text("OK"),
                              onPressed: () {
                                Get.to(QrPassPoc(model: _model));
                              }));
                      qrText = "Loaded!";
                    });
                  } else {
                    setState(() {
                      qrText = "Other!";
                    });
                  }
                },
                child: Text(qrText),
              ))
        ]),
      ),
    );
  }

  Widget getQrCodeScannerView() {
    return Expanded(
      flex: 2,
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
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      Logger.logDebug("context in qr_scan_page._onQrViewCreated.listen - " +
          _context.hashCode.toString());
      setState(() {
        // make call here
        dynamic gzipEncodedData = base64Decode(scanData);
        List<int> decodedGZipResult = GZipCodec().decode(gzipEncodedData);
        String decodedUtf8String = utf8.decode(decodedGZipResult);
        Map<String, dynamic> dataAsJson = json.decode(decodedUtf8String);
        try {
          _model = PassModel.fromJson(dataAsJson);
          if (_validateQrPassModel(_model)) {
            _addPassBloc(_model); // Bloc will check local storage if necessary
          } else {
            displayError(
                "Pass not valid! Please sign in the visitor manually.");
          }
        } catch (e) {
          displayError(
              "Error! Please sign in the visitor manually. Error details: ${e.toString()}");
        }
      });
    });
  }

  bool _validateQrPassModel(PassModel model) {
    DateTime validFrom = DateTime.parse(model.dateValidFrom);
    DateTime validTo = DateTime.parse(model.dateExpiry);
    DateTime now = DateTime.now();
    bool validFromCheck = validFrom.isBefore(now);
    bool validToCheck = validTo.isAfter(now);
    return (validFromCheck && validToCheck);
  }

  void displayError(String message) {
    Get.defaultDialog(
        title: "Error!",
        content: SingleChildScrollView(
          child: Column(
            children: [Text(message)],
          ),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _addPassBloc(PassModel model) {
    //ValidateQrPassBloc bloc = sl<ValidateQrPassBloc>();
    Logger.logDebug("context in qr_scan_page._addPassBloc - " +
        context.hashCode.toString());
    //BlocProvider.of<ValidateQrPassBloc>(context).add(ValidateQrPass(Params(pass: PassRequestModel.fromPassModel(model))));
    bloc.add(
        ValidateQrPass(Params(pass: PassRequestModel.fromPassModel(model))));

    ///bloc.close();
  }
}

/**

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
