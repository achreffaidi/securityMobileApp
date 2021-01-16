import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:security/util/CustomEncoder.dart';
import 'package:security/util/CustomHashingFunctions.dart';
import 'package:security/util/styling/Text.dart';
import 'package:security/util/Extensions.dart';
import 'package:security/widget/TextInput.dart';
class HashingUI extends StatefulWidget {
  @override
  _HashingUIState createState() => _HashingUIState();
}

class _HashingUIState extends State<HashingUI> {
  
  TextEditingController _input = TextEditingController();
  TextEditingController _output = TextEditingController();
  int _selected = 0 ;
  String dropdownValue = 'SHA-1';
  @override
  void initState() {
    super.initState();

  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(80, 0, 0, 1),
          title: Text("Hashing"),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(80, 0, 0, 1),Color.fromRGBO(20, 0, 0, 1), Color.fromRGBO(15, 0, 0, 1)])),
          child: Center(
            child: _getBody(context)
          ),

        )
    );
  }

  _getBody(BuildContext context) {
    double inputHeight = MediaQuery.of(context).size.height/4;
    return Column(
      children: [
        buildCustomInputField(true,"write something", _input, inputHeight,true,true,this,callback: (v)=> _onTextChange(v)),
        _getToggleButton(),
        buildCustomInputField(false,"", _output, inputHeight,true,false,this)
      ],
    );
  }


  _getToggleButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: DropdownButton<String>(
          style: buttonStyle,
          value: dropdownValue,
          dropdownColor: Colors.black87,
          isExpanded: true,
          elevation: 5,
          focusColor: Colors.red,
          underline: Container(),
          itemHeight: 50,
          icon: Icon(Icons.keyboard_arrow_down,color: Colors.red,),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
              _output.text = CustomHashing.hash(dropdownValue,_input.text);
            });
          },
          items: <String>['SHA-1', 'SHA-224', 'SHA-256', 'SHA-384','SHA-512', 'MD5']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: _getListItem(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Null _onTextChange(String v) {
      _output.text = CustomHashing.hash(dropdownValue,_input.text);
    setState(() {
    });
  }

  _getListItem(String value) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Card(
        color: Colors.black45,
        child: Center(child: Text(value,style: buttonStyle,)),
      ),
    );
  }

}

