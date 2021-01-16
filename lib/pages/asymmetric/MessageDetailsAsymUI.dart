import 'dart:convert';

import 'package:fast_rsa/model/bridge.pbenum.dart';
import 'package:fast_rsa/rsa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_widget/flutter_json_widget.dart';
import 'package:security/util/AsymmetricUtil.dart';
import 'package:security/util/messaging/Message.dart';
import 'package:security/util/styling/Text.dart';
import 'package:security/widget/TextInput.dart';

class MessageDetailAsymUI extends StatefulWidget {

  final ExtendedMessage message;
  final String publicKey;

  const MessageDetailAsymUI({Key key, this.message, this.publicKey}) : super(key: key);
  @override
  _MessageDetailAsymUIState createState() => _MessageDetailAsymUIState();
}

class _MessageDetailAsymUIState extends State<MessageDetailAsymUI> {

  TextEditingController _raw = TextEditingController();
  TextEditingController _message = TextEditingController();
  TextEditingController _signature = TextEditingController();
  TextEditingController _validationResult = TextEditingController();
  bool isValidating = true;
  var obj ;


  @override
  void initState() {
    super.initState();
    obj = json.decode(widget.message.text);
    initFields();
    validateSignature();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(80, 0, 0, 1),
          title: Text("Message Details"),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(80, 0, 0, 1),Color.fromRGBO(20, 0, 0, 1), Color.fromRGBO(15, 0, 0, 1)])),
          child: Center(
            child: Center(
              child: getBody(),
            ),
          ),

        )
    );
  }

  getBody() {
    double inputHeight = MediaQuery.of(context).size.height/4;
    _raw.text = widget.message.text;
    _message.text = widget.message.message;

    return SingleChildScrollView(
      child: Container(child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 50,),
          Text("Sender : ${widget.message.senderID}",style: buttonStyle,),
          Text("TimeStamp : ${widget.message.date.microsecondsSinceEpoch}",style: buttonStyle,),
          Text("Encryption Algorithm : RSA 2048 - SHA256 PSS",style: buttonStyle,),
          SizedBox(height: 50,),
          Text("Received Message: ",style: buttonStyle,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: JsonViewerWidget(obj),
            )),
          ),
          SizedBox(height: 50,),
          Text("Decrypted Message: ",style: buttonStyle,),
          buildCustomInputField(false,"Your Message", _message, inputHeight,true,false,this),
          SizedBox(height: 50,),
          Text("Signature: ",style: buttonStyle,),
          buildCustomInputField(false,"Your Message", _signature, inputHeight,true,false,this),
          SizedBox(height: 50,),
          Text("Signature Validation: ",style: buttonStyle,),
          isValidating?getContainer(CircularProgressIndicator(),inputHeight/3):buildCustomInputField(false,"Your Message", _validationResult, inputHeight/3,false,false,this),

        ],
      ),),
    );
  }

  void validateSignature() async {
    String sig = obj["signature"];
    String message = widget.message.message;
    bool isValid = false;
         try{
           isValid = await AsymmetricUtil.validate(message.trim(), sig, widget.publicKey);
         }catch(e){

         }
        isValidating = false;
        _validationResult.text = isValid?"Valid Signature":"Invalid Signature";
        setState(() {});
  }

  initFields(){
    _signature.text = obj['signature'];
    _message.text = widget.message.message;
  }

  getContainer(Widget child,double height){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.black38,
          border: Border.all(
            color: Colors.red,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Center(child: child,),
    );
  }
}
