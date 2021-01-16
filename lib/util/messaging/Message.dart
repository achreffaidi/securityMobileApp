class Message{
   String text;
   String senderID;
   String receiverID;
   DateTime date;

  Message(String text,String senderID,String receiverID,DateTime time){
    this.text =text??"" ;
    this.senderID = senderID??"" ;
    this.receiverID = receiverID??"";
    this.date = time;
  }

  @override
  String toString() {
    return senderID +" : "+ text;
  }
}


class ExtendedMessage extends Message {

  String message;
  String privateKey;
  String publicKey;
  ExtendedMessage(String text,String senderID,String receiverID,DateTime time,String message,String privateKey,String publicKey) : super('', '', '', null){

    this.text =text??"" ;
    this.senderID = senderID??"" ;
    this.receiverID = receiverID??"";
    this.date = time;
    this.message = message;
    this.privateKey = privateKey;
    this.publicKey = publicKey;
  }

  @override
  String toString() {
    return senderID +" : "+ text;
  }
}