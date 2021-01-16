import 'dart:convert';

import 'package:fast_rsa/model/bridge.pb.dart';
import 'package:fast_rsa/rsa.dart';
import 'package:security/util/messaging/Message.dart';

class AsymmetricUtil{


   static Future<String>  encrypt(String message,String publicKey) async{
     var result = await RSA.encryptOAEP(message, "", Hash.HASH_SHA256, publicKey);
     return result;
   }

   static Future<String> sign(String message, String privateKey) async {
     var result = await RSA.signPSS(message, Hash.HASH_SHA256, SaltLength.SALTLENGTH_AUTO, privateKey);
     return result;
   }

   /*
   public key of the receiver: used for encryption
   private key of sender: used for signing
    */
   static Future<String> encryptAndSign(String message, String publicKey,String privateKey) async {

     var empty="";
     int size = -1;
     int messageSize = message.length;
     int targetSize =  ((messageSize/148).ceil())*148;
     message = message.padRight(targetSize);
     for(int i = 0;i<message.length/148;i++){
       print("_____________________________");
       var x = message.substring(i,(i+1)*148);
       print(x);
       print(x.length);
       var y = await encrypt(x.padRight(148), publicKey);
       if(size==-1) size = y.length;
       print(y.length);
       print("_____________________________");
       empty = empty + y;
     }

     var signed = {
       "message":empty,
       "blockSize":size,
       "signature":await sign(message.trim(),privateKey)
     };

     return jsonEncode(signed);
   }

   static Future<ExtendedMessage> decrypt(Message message, String publicKey,String privateKey) async {

     var obj = json.decode(message.text);
     int blockSize = obj['blockSize'];
     String text = obj['message'];
     String empty = "";
     for(int i = 0;i<text.length/blockSize;i++){
       empty = empty + await RSA.decryptOAEP(text.substring(i,(i+1)*blockSize).padRight(blockSize), "", Hash.HASH_SHA256, privateKey);
     }
     return ExtendedMessage(message.text, message.senderID, message.receiverID, message.date, empty.trim(), privateKey, publicKey);

   }

   static Future<bool> validate(String message,String signature,String publicKey) async {
     var isValide = await RSA.verifyPSS(signature,message, Hash.HASH_SHA256, SaltLength.SALTLENGTH_AUTO, publicKey);
     return isValide;
   }





}