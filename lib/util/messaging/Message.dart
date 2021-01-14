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