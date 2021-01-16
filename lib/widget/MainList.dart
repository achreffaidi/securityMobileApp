import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security/pages/AsymmetricUI.dart';
import 'package:security/pages/EncodDecodUI.dart';
import 'package:security/pages/HashingCrackingUI.dart';
import 'package:security/pages/SymmetricUI.dart';
import 'package:security/pages/asymmetric/Messenger.dart';
import 'package:security/pages/asymmetric/DecryptAsyUI.dart';
import 'package:security/pages/asymmetric/EncryptAsyUI.dart';
import 'package:security/pages/asymmetric/KeyManagerUI.dart';
import 'package:security/pages/asymmetric/SignAsyUI.dart';
import 'package:security/pages/asymmetric/VerifyAsyUI.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width/2,
              child: Image.asset('assets/logo.png')),
        SizedBox(
        width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.width*0.4,
        child: TypewriterAnimatedTextKit(
          speed: const Duration(milliseconds: 150),
          text: [
            "\$Your guide into Cryptography",
            "\$You will find all you need here",
            "\$From Coding, Hashing, Encrypting, and even Cracking !",
          ],
          textStyle: GoogleFonts.alegreyaSansSc(textStyle: TextStyle(color: Colors.white,fontSize: 35)),
          textAlign: TextAlign.start,
        ),
      ),
          Column(
            children: [
              ButtonBuilder.buildRaisedButton(context, () {
                _navigateTo(context, EncodingDecodingUI());
              }, "Encoding"),
              ButtonBuilder.buildRaisedButton(context, () {
                _navigateTo(context, HashingCrackingUI());
              }, "Hashing"),
              ButtonBuilder.buildRaisedButton(context, () {
                _navigateTo(context, SymmetricUI());
              }, "Symmetric Encryption"),
              ButtonBuilder.buildRaisedButton(context, () {
                _navigateTo(context, AsymmetricUI());
              }, "Asymmetric Encryption"),

            ],
          ),
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
          }, "Encoding"),
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
            _navigateTo(context, DecryptUI());
          }, "Decrypt"),
          ButtonBuilder.buildRaisedButton(context, callback , "ChatRoom"),
        ],
      ),
    );
  }
  static getAsymmetricList(BuildContext context,hasKeys){
    return Container(
      child: Column(
        children: [
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, KeyManagerUI());
          }, "Key Manager"),
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, EncryptAsyUI());
          }, "Encrypt",active: hasKeys),
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, DecryptAsyUI());
          }, "Decrypt",active: hasKeys),
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, SignAsyUI());
          }, "Sign",active: hasKeys),
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, VerifyAsyUI());
          }, "Verify Signature",active: hasKeys),
          ButtonBuilder.buildRaisedButton(context, () {
            _navigateTo(context, MessengerUI());
          }, "Messenger",active: hasKeys),
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
