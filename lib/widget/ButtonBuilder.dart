import 'package:flutter/material.dart';
import 'package:security/util/styling/Text.dart';

class ButtonBuilder{
  static Widget buildRaisedButton(
      BuildContext context, Null Function() callback, String text) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: callback,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.black38,
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(text,style: buttonStyle,)),
          ),
        ),
      );
}