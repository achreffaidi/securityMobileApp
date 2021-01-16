import 'package:flutter/material.dart';
import 'package:security/util/styling/Text.dart';

class ButtonBuilder{
  static Widget buildRaisedButton(
      BuildContext context, Function() callback, String text,{bool active = true}) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: active?callback:null,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.black38,
                border: Border.all(
                  color: active?Colors.red[900]:Colors.grey,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(text,style: buttonStyle,)),
          ),
        ),
      );
}