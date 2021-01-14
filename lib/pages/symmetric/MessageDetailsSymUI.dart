import 'package:flutter/material.dart';
import 'package:security/util/SymmetricUtil.dart';
import 'package:security/util/messaging/Message.dart';
import 'package:security/util/styling/Text.dart';
import 'package:security/widget/TextInput.dart';

class MessageDetailSymUI extends StatefulWidget {

  final Message message;
  final String password;

  const MessageDetailSymUI({Key key, this.message, this.password}) : super(key: key);
  @override
  _MessageDetailSymUIState createState() => _MessageDetailSymUIState();
}

class _MessageDetailSymUIState extends State<MessageDetailSymUI> {

  TextEditingController _raw = TextEditingController();
  TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(2, 55, 71, 1),
          title: Text("Symmetric"),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(2, 55, 71, 1),Color.fromRGBO(1, 30, 40, 1), Color.fromRGBO(1, 22, 28, 1)])),
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
    _message.text = SymmetricUtil.decrypt(" ", widget.message.text, widget.password);
    return Container(child: Column(

      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Sender : ${widget.message.senderID}",style: buttonStyle,),
        Text("TimeStamp : ${widget.message.date.microsecondsSinceEpoch}",style: buttonStyle,),
        Text("Encryption Algorithm : AES CBC",style: buttonStyle,),
        Text("Used Key: ${widget.password}",style: buttonStyle,),
        Text("Original Message: ",style: buttonStyle,),
        buildCustomInputField(false,"Your Message", _raw, inputHeight,true,false,this),
        Text("Decrypted Message: ",style: buttonStyle,),
        buildCustomInputField(false,"Your Message", _message, inputHeight,true,false,this),
      ],
    ),);
  }

}
