import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security/pages/EncodDecodUI.dart';
import 'package:security/pages/codedecod/Coding.dart';
import 'package:security/pages/codedecod/Decoding.dart';
import 'package:security/pages/messagingTest.dart';
import 'package:security/util/styling/Text.dart';

class ListBuilder  {
  
  
  static getMainList(BuildContext context){
    return Container(
      child: Column(
        children: [
          buildRaisedButton(context, () {
            _navigateTo(context, MessagingUI());
          }, "Testing"),
          buildRaisedButton(context, () {
            _navigateTo(context, EncodingDecodingUI());
          }, "Encoding/Decoding"),
          buildRaisedButton(context, () {
            _navigateTo(context, MessagingUI());
          }, "Hashing"),
          buildRaisedButton(context, () {
            _navigateTo(context, MessagingUI());
          }, "Messenger App: Async Encryption"),
          buildRaisedButton(context, () {
            _navigateTo(context, MessagingUI());
          }, "ChatRoom App: Sync Encryption"),
        ],
      ),
    );
  }

  static getCodingDecodingList(BuildContext context){
    return Container(
      child: Column(
        children: [
          buildRaisedButton(context, () {
            _navigateTo(context, CodingUI());
          }, "Coding"),
          buildRaisedButton(context, () {
            _navigateTo(context, DecodingUI());
          }, "Decoding"),
        ],
      ),
    );
  }

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

  static _navigateTo(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}
