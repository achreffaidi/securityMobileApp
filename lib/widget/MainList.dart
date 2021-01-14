import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security/pages/EncodDecodUI.dart';
import 'package:security/pages/HashingCrackingUI.dart';
import 'package:security/pages/SymmetricUI.dart';
import 'package:security/pages/codedecod/Coding.dart';
import 'package:security/pages/codedecod/Decoding.dart';
import 'package:security/pages/hashing/Cracking.dart';
import 'package:security/pages/hashing/Hashing.dart';
import 'package:security/pages/messagingTest.dart';
import 'package:security/pages/symmetric/DecryptUI.dart';
import 'package:security/pages/symmetric/EncryptUI.dart';
import 'package:security/util/styling/Text.dart';

import 'ButtonBuilder.dart';

class ListBuilder  {
  
  
  static getMainList(BuildContext context){
    return Container(
      child: Column(
        children: [
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, MessagingUI());
          }, "Testing"),
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, EncodingDecodingUI());
          }, "Encoding/Decoding"),
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, HashingCrackingUI());
          }, "Hashing"),
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, MessagingUI());
          }, "Messenger App: Async Encryption"),
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, SymmetricUI());
          }, "ChatRoom App: Sync Encryption"),
        ],
      ),
    );
  }

  static getCodingDecodingList(BuildContext context){
    return Container(
      child: Column(
        children: [
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, CodingUI());
          }, "Coding"),
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, DecodingUI());
          }, "Decoding"),
        ],
      ),
    );
  }
  static getHashingList(BuildContext context){
    return Container(
      child: Column(
        children: [
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, HashingUI());
          }, "Hashing"),
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, CrackingUI());
          }, "Cracking"),
        ],
      ),
    );
  }

  static getSymmetricList(BuildContext context,Function callback){
    return Container(
      child: Column(
        children: [
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, EncryptUI());
          }, "Encrypt"),
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, CrackingUI());
          }, "Decrypt"),
          ButtonBuilder.buildRaisedButton(context, callback , "ChatRoom"),
        ],
      ),
    );
  }


  static _navigateTo(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}
