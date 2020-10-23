import 'package:flutter/material.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_model.dart';

enum PassCategory { A, B, C, L }

enum PassType { PASS, LOA, NONE }

enum PassStatus { ACTIVE, REVOKED, EXPIRED }

// Create a Form widget.
class NewVisitorForm extends StatefulWidget {
  PassModel model;
  NewVisitorForm(this.model);

  @override
  NewVisitorFormState createState() {
    return NewVisitorFormState(model);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class NewVisitorFormState extends State<NewVisitorForm> {
  PassModel model;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  List<String> passTypes = ["PASS", "LOA"];
  TextEditingController _visitorNameController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();

  NewVisitorFormState(this.model);

  @override
  Widget build(BuildContext context) {
    if (model != null) {
      _visitorNameController.text = model.visitorName;
      _companyNameController..text = model.visitorCompany;
    }
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildNamePassTypeRow(context),
          _buildCompanyRow(context)
        ],
      ),
    );
  }

  Row _buildCompanyRow(BuildContext context) {
    return Row(
      children: [
        _companySelection()
      ],
    );
  }

  Row _buildNamePassTypeRow(BuildContext context) {
    return Row(
      children: <Widget>[
        _nameSelection(),
        SizedBox(width: 50.0),
        _passTypeSelection(),
      ],
    );
  }

  Widget _nameSelection() {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Text("Name:"),
          SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              controller: _visitorNameController,
              decoration: new InputDecoration(
                hintText: "Visitor Name",
              )
            )
          ),
        ],
      ),
    );
  }

  Widget _passTypeSelection() {
    String passOrLoa;
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Text("Pass/LOA"),
          SizedBox(width: 20),
          Expanded(
            child: DropdownButtonFormField(
              value: passOrLoa,
              hint: Text("PASS/LOA"),
              items: passTypes.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newPassType) =>
                  passOrLoa = newPassType,
              isDense: true,
              onTap: () => FocusScope.of(context)
                  .unfocus(), //workaround for flutter issue #47128
            )
          ),
        ],
      ),
    );
  }

 Widget  _companySelection() {
   return Expanded(
     flex: 1,
     child: Row(
       children: [
         Text("Company:"),
         SizedBox(width: 20),
         Expanded(
             child: TextFormField(
                 controller: _companyNameController,
                 decoration: new InputDecoration(
                   hintText: "Visitor Company",
                 )
             )
         ),
       ],
     ),
   );
 }

}
