import 'dart:convert';

import 'package:binary/binary.dart';
import 'package:flutter/services.dart';

class CustomEncoder{
  static String encodeToBase64(String s){
    return Base64Encoder().convert(s.codeUnits);}

  static String decodeFromBase64(String s){
    if(s.contains(" ")) return "";
    if(s.length%4!=0) return "Invalid format";
    return Base64Decoder().convert(s).map((e) => String.fromCharCode(e)).join();}


  static String encodeToBinary(String s){
    List<String> binary = s.codeUnits.map((int strInt) => strInt.toRadixString(2)).toList();
    return binary.join(" ");
  }
  static String decodeFromBinary(String s){

    for(int i = 0 ; i<s.length;i++){
      if(s[i]!="1"&&s[i]!="0"&&s[i]!=" ") return "Invalid format";
    }
    List<String> binary = s.trim().split(" ");
    for(String i in binary) if(i.length!=7&&i.length!=6) return "Invalid format";
    if(binary.isEmpty) return "";
    List<int> result = binary.map((String strInt) => int.parse(strInt,radix: 2)).toList();

    return String.fromCharCodes(result);
  }

 static  String encodeToAscii(String s){
    List<String> binary = s.codeUnits.map((int strInt) => strInt.toString()).toList();
    return binary.join(" ");
  }

  static  String decodeFromAscii(String s){

    List<String> list = s.trim().split(" ");
    if(list.isEmpty) return "";
    for(var x in list) if(!_isChar(x))  return "Invalid format";
    List<int> result = list.map((String strInt) => int.parse(strInt)).toList();
    for(int x in result) if(x==null)return "Invalid format";
    return String.fromCharCodes(result);
  }

  static bool _isChar(String result) {
    if (result == null) {
      return false;
    }
    var x = int.tryParse(result);
    return x != null && x<256;
  }


}