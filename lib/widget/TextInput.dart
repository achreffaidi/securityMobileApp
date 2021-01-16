import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:security/util/styling/Text.dart';
import 'package:security/util/Extensions.dart';

Widget buildCustomInputField(bool isActivated, String hint, TextEditingController controller, double height, bool hasCopy,bool hasPast,State state,{ Function(String) callback,  bool addShadow = true }) {
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: height,

      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(state.context).size.width,
            height: height,
            decoration: BoxDecoration(
                color: Colors.black38,
                border: Border.all(
                  color: Colors.red[900],
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
              hintStyle: TextStyle(color: Colors.white70),
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
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: addShadow?Colors.black87:Colors.transparent,
                ),
                  child: Row(
                children: [
                  hasCopy?IconButton(icon: Icon(Icons.copy,color: Colors.red[900],), onPressed: (){

                    FlutterClipboard.copy(controller.text).then((value) => state.toast("Copied to Clipboard"));
                  }):Container(),
                  hasPast?IconButton(icon: Icon(Icons.paste,color: Colors.red[900],), onPressed: (){
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
    ),
  );
}