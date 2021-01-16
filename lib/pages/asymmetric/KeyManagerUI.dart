import 'dart:convert';

import 'package:fast_rsa/model/bridge.pb.dart';
import 'package:fast_rsa/rsa.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:security/api/config.dart';
import 'package:security/util/CustomEncoder.dart';
import 'package:security/util/CustomHashingFunctions.dart';
import 'package:security/util/SymmetricUtil.dart';
import 'package:security/util/styling/Text.dart';
import 'package:security/util/Extensions.dart';
import 'package:security/widget/ButtonBuilder.dart';
import 'package:security/widget/TextInput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class KeyManagerUI extends StatefulWidget {
  @override
  _KeyManagerUIState createState() => _KeyManagerUIState();
}

class _KeyManagerUIState extends State<KeyManagerUI> {

  TextEditingController _public = TextEditingController();
  TextEditingController _private = TextEditingController();
  String dropdownValue = 'AES CBC';

  @override
  void initState() {
    super.initState();
    _initFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(80, 0, 0, 1),
          title: Text("Key Manager"),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(80, 0, 0, 1),
                    Color.fromRGBO(20, 0, 0, 1),
                    Color.fromRGBO(15, 0, 0, 1)
                  ])),
          child: Center(
              child: _getBody(context)
          ),

        )
    );
  }

  _getBody(BuildContext context) {
    double inputHeight = MediaQuery
        .of(context)
        .size
        .height / 4;
    return Column(
      children: [
        ButtonBuilder.buildRaisedButton(context, _generateKey, "GenerateKey"),
        buildCustomInputField(
            true,
            "",
            _public,
            inputHeight,
            true,
            false,
            this),
        buildCustomInputField(
            false,
            "",
            _private,
            inputHeight,
            true,
            false,
            this),
        ButtonBuilder.buildRaisedButton(
            context, _uploadKeys, "Upload to KeyServer",
            active: !(_public.text.isEmpty || _private.text.isEmpty)),
      ],
    );
  }


  _initFields() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _public.text = preferences.getString('publicKey');
    _private.text = preferences.getString('privateKey');
    setState(() {

    });
  }

  _generateKey() async {
    var pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false);
    pr.update(message: "Generating KeyPair ... ");
    pr.show();
    KeyPair result = await RSA.generate(2048);
    _public.text = result.getField(2);
    _private.text = result.getField(1);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('publicKey', result.getField(2));
    preferences.setString('privateKey', result.getField(1));
    pr.hide();
    setState(() {

    });
  }


  void _uploadKeys() async {
    var pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false);
    pr.update(message: "Uploading public key ... ");
    pr.show();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var username = preferences.getString('username');
    var body = {
      "username": username,
      "publicKey": _public.text
    };
    http.post(baseUrl + "asy/keys", body: body).then((http.Response res) {
      if (res.statusCode == 200) toast("Public key uploaded successfully");
      pr.hide();
    }).catchError((onError) {
      toast(onError.toString());
      pr.hide();
    });
  }
}
