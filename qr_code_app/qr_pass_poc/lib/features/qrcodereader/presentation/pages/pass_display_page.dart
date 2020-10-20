import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/displayed_pass_model.dart';

class PassDisplayPage extends StatefulWidget {
  final DisplayedPassModel pass;
  PassDisplayPage({@required this.pass});

  @override
  State<StatefulWidget> createState() => PassDisplayState(pass);
}

class PassDisplayState extends State {
  DisplayedPassModel pass;
  PassDisplayState(this.pass);

  clear(){
    setState(() {
      this.pass = null;
    });
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Center(
          child: Column(
            children: [
              PassDisplayWidget(this.pass),
              RaisedButton(child: Text("Clear Screen!"),onPressed: (){
                clear();
              },)
            ],
          ),
        ),
      );
  }
}

class PassDisplayWidget extends StatelessWidget {
  final DisplayedPassModel pass;
  PassDisplayWidget(this.pass);

  @override
  Widget build(BuildContext context) {
    if (pass == null) {
      return Container();
    } else {
      return Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
          side: BorderSide(
              color: Color(0xFF009900),
              width: 3.0),
        ),
        child: _buildCardBody(context),
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
                backgroundImage: CachedNetworkImageProvider(pass.visitorImageLink),
                backgroundColor: Colors.white,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Pass Category: ${pass.category}"),
              Text("Pass Number: ${pass.passNumber}"),
              Text("Visitor Name: ${pass.visitorName}")
            ],
          )
        ],
      ),
    );
  }
}