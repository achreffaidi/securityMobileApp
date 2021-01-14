import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';

class CustomHashing{


   static String hash(String algorithm, String text){
     var bytes = utf8.encode(text);

     switch(algorithm){
       case "SHA-1" : return sha1.convert(bytes).toString();
       case "SHA-224" : return sha224.convert(bytes).toString();
       case "SHA-256" : return sha256.convert(bytes).toString();
       case "SHA-384" : return sha384.convert(bytes).toString();
       case "SHA-512" : return sha512.convert(bytes).toString();
       case "MD5" : return md5.convert(bytes).toString();
       default: return sha1.convert(bytes).toString();
     }

  }

   static Future<String> loadAsset() async {
     return await rootBundle.loadString('assets/dictionary.txt');
   }




}

class CrackingInput{
  String algorithm;
  String text;
  List<String> dictionary;
  int from;
  int until;

 CrackingInput(this.algorithm, this.text, this.dictionary,this.from,this.until);
}

String  crack(CrackingInput input) {
  int total = input.dictionary.length;
  for(int i = input.from ; i<input.until && i<total;i++){
    if(i%10000==0){
      print(i);
    }
    if(CustomHashing.hash(input.algorithm,input.dictionary[i])==input.text){
      return input.dictionary[i];
    }
  }
  return null;
}