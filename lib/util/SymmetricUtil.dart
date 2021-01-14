
import 'package:encrypt/encrypt.dart';

class SymmetricUtil{


  static String encrypt(String algorithm, String text,String myKey){

    if(myKey.isEmpty) return "";
    while(myKey.length<32){
      myKey = myKey + myKey;
    }

    final plainText = text;
    final key = Key.fromUtf8(myKey.substring(0,32));
    final iv = IV.fromLength(16);

    Encrypter encrypter ;
    switch(algorithm){
      case "AES CBC" : encrypter = Encrypter(AES(key,mode: AESMode.cbc));break ;
      case "AES CFB-64" : encrypter = Encrypter(AES(key,mode: AESMode.cfb64));break ;
      case "AES CTR" : encrypter = Encrypter(AES(key,mode: AESMode.ctr));break ;
      case "AES ECB" : encrypter = Encrypter(AES(key,mode: AESMode.ecb));break ;
      case "AES OFB-64/GCTR" : encrypter = Encrypter(AES(key,mode: AESMode.ofb64Gctr));break ;
      case "AES OFB-64" : encrypter = Encrypter(AES(key,mode: AESMode.ofb64));break ;
      case "AES SIC" : encrypter = Encrypter(AES(key,mode: AESMode.sic));break ;
      default: encrypter = Encrypter(AES(key,mode: AESMode.cbc));break ;
    }

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    return encrypted.base64;
  }

  static String decrypt(String algorithm, String text,String myKey) {
    try{
      if (myKey.isEmpty) return "";
      while (myKey.length < 32) {
        myKey = myKey + myKey;
      }

      final plainText = text;
      final key = Key.fromUtf8(myKey.substring(0, 32));
      final iv = IV.fromLength(16);

      Encrypter encrypter;
      switch (algorithm) {
        case "AES CBC" :
          encrypter = Encrypter(AES(key, mode: AESMode.cbc));
          break;
        case "AES CFB-64" :
          encrypter = Encrypter(AES(key, mode: AESMode.cfb64));
          break;
        case "AES CTR" :
          encrypter = Encrypter(AES(key, mode: AESMode.ctr));
          break;
        case "AES ECB" :
          encrypter = Encrypter(AES(key, mode: AESMode.ecb));
          break;
        case "AES OFB-64/GCTR" :
          encrypter = Encrypter(AES(key, mode: AESMode.ofb64Gctr));
          break;
        case "AES OFB-64" :
          encrypter = Encrypter(AES(key, mode: AESMode.ofb64));
          break;
        case "AES SIC" :
          encrypter = Encrypter(AES(key, mode: AESMode.sic));
          break;
        default:
          encrypter = Encrypter(AES(key, mode: AESMode.cbc));
          break;
      }

      Encrypted encrypted = Encrypted.from64(plainText);
      final decrypted = encrypter.decrypt(encrypted, iv: iv);

      return decrypted;
    }catch(e){
      return "Invalid Key ";
    }
  }


}