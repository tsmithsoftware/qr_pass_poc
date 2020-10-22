
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:qr_pass_poc/core/presentation/widgets/qr_button.dart';
import 'base_injection_container.dart' as di;
import 'base_injection_container.dart';
import 'features/qrcodereader/presentation/bloc/qr_pass_bloc.dart';
import 'features/qrcodereader/presentation/pages/qr_scan_page.dart';

void main() async {
  await di.init();
  runApp(GetMaterialApp(home: QrPassPoc()));
}

class QrPassPoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ValidateQrPassBloc>(),
      child: Row(
        children: [
          Expanded(child: Text("This widget represents some widgets on the Visitor Sign In Page")),
          QrButton.primary(
            "Sign in using Pass",
              (){
              Get.to(QrScanPage());
              }
          )
        ],
      ),
    );
  }

}
