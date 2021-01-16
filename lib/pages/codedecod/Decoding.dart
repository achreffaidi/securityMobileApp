import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:security/util/CustomEncoder.dart';
import 'package:security/util/styling/Text.dart';
import 'package:security/util/Extensions.dart';
import 'package:security/widget/TextInput.dart';
class DecodingUI extends StatefulWidget {
  @override
  _DecodingUIState createState() => _DecodingUIState();
}

class _DecodingUIState extends State<DecodingUI> {
  
  TextEditingController _input = TextEditingController();
  TextEditingController _output = TextEditingController();
  int _selected = 0 ;

  @override
  void initState() {
    super.initState();

  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(80, 0, 0, 1),
          title: Text("Decoding"),
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
return ToggleButtons(
      disabledBorderColor: Colors.white,
      borderColor: Colors.black54,
      selectedColor: Colors.red,
      color: Colors.white,
      disabledColor: Colors.white,
      selectedBorderColor: Colors.red,
      onPressed: (selected){
        _selected = selected;
        _onTextChange(_input.text);
        setState(() {});
      },
      isSelected: [_selected==0,_selected==1,_selected==2],
      children: [
        Container(child : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("BASE64",style: TextStyle(fontSize: 20),),
        ),),
        Container(child : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("BINARY",style: TextStyle(fontSize: 20),),
        )),
        Container(child : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("ASCII",style: TextStyle(fontSize: 20),),
        ),),

      ],);
  }

  Null _onTextChange(String v) {

      if(_selected==0){
        _output.text = CustomEncoder.decodeFromBase64(_input.text);
      }else if(_selected==1){
        _output.text = CustomEncoder.decodeFromBinary(_input.text);
      }else{
        _output.text = CustomEncoder.decodeFromAscii(_input.text);
      }

    
    setState(() {
    });
  }


}
