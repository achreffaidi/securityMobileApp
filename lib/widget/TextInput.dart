import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:security/util/styling/Text.dart';
import 'package:security/util/Extensions.dart';

Widget buildCustomInputField(bool isActivated, String hint, TextEditingController controller, double height, bool hasCopy,bool hasPast,State state,{ Function(String) callback }) {
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Stack(
      children: [
        Container(
          width: MediaQuery.of(state.context).size.width,
          height: height,
          decoration: BoxDecoration(
              color: Colors.black38,
              border: Border.all(
                color: Colors.blue,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12)),
          child: TextField(
            onChanged: (v){
              if(callback!=null){
                callback(v);
              }
            },
            controller: controller,style: buttonStyle ,decoration: InputDecoration(
            hintText: hint,
            enabled: isActivated,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ),
        Positioned(
            bottom: 5,
            right: 5,
            child: Container(child: Row(
              children: [
                hasCopy?IconButton(icon: Icon(Icons.copy,color: Colors.blue,), onPressed: (){

                  FlutterClipboard.copy(controller.text).then((value) => state.toast("Copied to Clipboard"));
                }):Container(),
                hasPast?IconButton(icon: Icon(Icons.paste,color: Colors.blue,), onPressed: (){
                  FlutterClipboard.paste().then((value) {
                    controller.text= value;
                    callback(value);
                    state.setState(() {

                    });
                  });
                }):Container(),
              ],
            ) ))
      ],
    ),
  );
}