import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:security/util/CustomEncoder.dart';
import 'package:security/util/styling/Text.dart';
import 'package:security/util/Extensions.dart';
import 'package:security/widget/ButtonBuilder.dart';
import 'package:security/widget/TextInput.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SettingsUI extends StatefulWidget {
  @override
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  
  TextEditingController _input = TextEditingController();
  TextEditingController _output = TextEditingController();
  int _selected = 0 ;

  @override
  void initState() {
    super.initState();
    initName();
  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(2, 55, 71, 1),
          title: Text("Settings"),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(2, 55, 71, 1),Color.fromRGBO(1, 30, 40, 1), Color.fromRGBO(1, 22, 28, 1)])),
          child: Center(
            child: _getBody(context)
          ),

        )
    );
  }

  _getBody(BuildContext context) {
    double inputHeight = MediaQuery.of(context).size.height/8;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Username:",style: buttonStyle),
        ),
        buildCustomInputField(true,"User Name", _input, inputHeight,true,true,this),
        ButtonBuilder.buildRaisedButton(context, (){
          saveName();
        }, "Save"),
      ],
    );
  }

  void saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _input.text);
    toast("Username Saved!");
  }

  void initName()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _input.text = prefs.get('username')??"";

  }




}
