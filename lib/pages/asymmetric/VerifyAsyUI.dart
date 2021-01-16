import 'dart:convert';

import 'package:fast_rsa/model/bridge.pb.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:security/util/CustomEncoder.dart';
import 'package:security/util/CustomHashingFunctions.dart';
import 'package:security/util/SymmetricUtil.dart';
import 'package:security/util/styling/Text.dart';
import 'package:security/util/Extensions.dart';
import 'package:security/widget/ButtonBuilder.dart';
import 'package:security/widget/TextInput.dart';
import 'package:fast_rsa/rsa.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyAsyUI extends StatefulWidget {
  @override
  _VerifyAsyUIState createState() => _VerifyAsyUIState();
}

class _VerifyAsyUIState extends State<VerifyAsyUI> {

  TextEditingController _input = TextEditingController();
  TextEditingController _signature = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _output = TextEditingController();

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
          title: Text("Verify"),
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
        buildCustomInputField(
            true,
            "Message",
            _input,
            inputHeight,
            false,
            true,
            this),
        buildCustomInputField(
            true,
            "Signature",
            _signature,
            inputHeight,
            false,
            true,
            this),
        buildCustomInputField(
            true,
            "Public Key",
            _password,
            inputHeight / 2,
            true,
            false,
            this,
            callback: (v) => {setState(() {})}),
        ButtonBuilder.buildRaisedButton(
            context, _verify, "Verify signature", active: _password.text.isNotEmpty),
        buildCustomInputField(
            true,
            "",
            _output,
            inputHeight/3,
            false,
            false,
            this)
      ],
    );
  }

  _verify() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var public = preferences.get('publicKey');
    var isValide = await RSA.verifyPSS(_signature.text,_input.text, Hash.HASH_SHA256, SaltLength.SALTLENGTH_AUTO, public);
    _output.text = isValide?"Valid Signature":"Invalid Signature";
    setState(() {

    });
  }

  _initFields() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _password.text = preferences.getString('publicKey');
    setState(() {

    });
  }
}

