import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_pass_poc/core/logger.dart';
import 'package:qr_pass_poc/core/presentation/widgets/qr_button.dart';
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
  TextEditingController _textEditingController = TextEditingController();

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
                              Text("Please check the below details. If they are acceptable, please press OK to return to main page and continue with signing in the user."),
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
                child: Column(
                  children: [
                    Text("Please scan the BP-issued QR code with the above camera. If the QR code cannot be read, please enter the Pass ID into the below box and press Submit"),
                    TextFormField(
                      controller: _textEditingController,
                    ),
                    QrButton.primary("Submit", () => {
                     _addPassBloc(PassModel(passNumber: int.tryParse(_textEditingController.text)))
                    })
                  ],
                ),
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
    bloc.add(
        ValidateQrPass(Params(pass: PassRequestModel.fromPassModel(model))));
  }
}
