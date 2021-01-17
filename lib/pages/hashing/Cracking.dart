import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:security/util/CustomEncoder.dart';
import 'package:security/util/CustomHashingFunctions.dart';
import 'package:security/util/styling/Text.dart';
import 'package:security/util/Extensions.dart';
import 'package:security/widget/ButtonBuilder.dart';
import 'package:security/widget/TextInput.dart';

class CrackingUI extends StatefulWidget {
  @override
  _CrackingUIState createState() => _CrackingUIState();
}

class _CrackingUIState extends State<CrackingUI> {

  TextEditingController _input = TextEditingController();
  TextEditingController _output = TextEditingController();
  String dropdownValue = 'SHA-1';
  Widget crackingButton;
  String buttonText = "Start Cracking";
  bool isActivated = true;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(80, 0, 0, 1),
          title: Text("Cracking"),
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
        buildCustomInputField(true,"write something", _input, inputHeight,true,true,this),
        _getDropdownButton(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 12),
          child: Text("Crack using a 5M words dictionary.",style: TextStyle(color: Colors.white),),
        ),
        ButtonBuilder.buildRaisedButton(context, isActivated? () {
        _startCracking(context);
    }:null, buttonText),
        buildCustomInputField(false,"", _output, inputHeight,true,false,this)
      ],
    );
  }


  _getDropdownButton() {
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

  void _startCracking(BuildContext context) async {
    setState(() {
      buttonText = "Cracking using 5M word Dictionary ...";
      isActivated = false;
    });
    CustomHashing.loadAsset().then((value) async {
      List<String> dic = value.split('\n');

      String val;
      for(int i = 0; i<dic.length/10000;i++){
        CrackingInput input = CrackingInput(dropdownValue, _input.text.trim(),dic,i*10000,(i+1)*10000);
        val = await compute(crack,input);
        setState(() {
          buttonText = "Cracking : ${i*10000}/${dic.length}";
        });
        if(val!=null) break;
      }
      if(val!=null){
        toast("Found: "+val);
        _output.text = val;

      }else{
        toast("Can't find it!");
      }
      setState(() {
        buttonText = "Start Cracking";
        isActivated = true;
      });
    }).catchError((error){
      toast(error.toString());
    });
    
  }
}




