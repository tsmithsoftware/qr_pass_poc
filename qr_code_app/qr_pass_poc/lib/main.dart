import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_pass_poc/core/presentation/widgets/qr_button.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_model.dart';
import 'base_injection_container.dart' as di;
import 'core/constants.dart';
import 'core/logger.dart';
import 'features/qrcodereader/presentation/pages/new_visitor_form.dart';
import 'features/qrcodereader/presentation/pages/qr_scan_page.dart';

void main() async {
  await di.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(GetMaterialApp(home: QrPassPoc()));
  });
}

class QrPassPoc extends StatelessWidget {
  PassModel model;
  QrPassPoc({this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          Column(
            children: [
              //PassDisplayWidget(model: model),
              SingleChildScrollView(
                child: Container(
                  color: kBPPaleGrey1,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "New Visitor",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(color: kBPGreen),
                            ),
                          ),
                          QrButton.primary("Sign in using Pass", () {
                            Get.to(QrScanPage());
                          })
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: NewVisitorForm(model),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          QrButton.primary(
                      "Submission - Not Implemented", (){}
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PassDisplayWidget extends StatefulWidget {
  PassModel model;
  PassDisplayWidget({this.model});

  @override
  _PassDisplayWidgetState createState() =>
      _PassDisplayWidgetState(model: model);
}

class _PassDisplayWidgetState extends State<PassDisplayWidget> {
  PassModel model;
  _PassDisplayWidgetState({this.model});

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return Container(height: 0, width: 0);
    } else {
      return SizedBox(
        width: 400,
        height: 150,
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
            side: BorderSide(color: Colors.green, width: 3.0),
          ),
          child: _buildCardBody(context),
        ),
      );
    }
  }

  Widget _buildCardBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: <Widget>[
          Container(
              width: 100.0,
              height: 100.0,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/default_user.png'),
              )),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(model.visitorName),
                Text(
                  model.visitorCompany,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                Text("Valid from: ${model.dateValidFrom}"),
                Text("Expires at: ${model.dateExpiry}")
              ],
            ),
          )
        ],
      ),
    );
  }
}
