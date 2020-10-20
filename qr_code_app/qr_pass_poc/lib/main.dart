import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_pass_poc/features/qrcodereader/presentation/bloc/bloc.dart';
import 'package:qr_pass_poc/features/qrcodereader/presentation/pages/pass_display_page.dart';
import 'base_injection_container.dart' as di;
import 'base_injection_container.dart';

void main() async {
  await di.init();
  runApp(GetMaterialApp(home: QRViewExample()));
}

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  var qrText = '';
  var flashState = flashOn;
  var cameraState = frontCamera;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocProvider(
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
                      Text('This is the result of scan: $qrText'),
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
                            print("In build body listening for GetPassState => $state");
                            if (state is GetPassInitial) {
                              return Container();
                            }
                            else if (state is GetPassError) {
                              return Container(child: Text("Error! ${state.failure.message}"));
                            }
                            else if (state is GetPassLoading) {
                              return LoadingIndicator();
                            }
                            else if (state is GetPassLoaded) {
                              return PassDisplayPage(pass: state.pass);
                            }
                            else return Container(
                                child: Column(
                                  children: [
                                    Text("No GetPassState!")
                                  ],
                                ),
                              );
                          },
                        ),
                        ControlsWidget()
                      ],
                    )
                ),
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
        qrText = scanData;
        if (scanData is int) {
          addPassBloc(context, (scanData as int));
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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

class ControlsWidget extends StatefulWidget {
  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<ControlsWidget> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () { addPassBloc(context, 1); },
      child: Text("Click to load!"),
    );
  }
}

void addPassBloc(BuildContext context, int number) => BlocProvider.of<GetPassBloc>(context).add(GetConcretePass(number));