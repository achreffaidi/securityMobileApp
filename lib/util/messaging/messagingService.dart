import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:security/api/config.dart';
import 'package:security/api/model/users.dart';
import 'package:security/util/AsymmetricUtil.dart';

import 'Message.dart';

class MessagingService extends ChangeNotifier {

  bool hasKeys = false;
  bool initialized = false;
  String channel;
  String username;
  String myPrivateKey;
  SocketIO socketIO;
  List<User> users = List();
  List<ExtendedMessage> messages = List<ExtendedMessage>();
  List<ExtendedMessage> discussions = List<ExtendedMessage>();
  bool isAsync = false ;


  void initIsAsync(bool isAsync){
    this.isAsync = isAsync ;
  }
  void initPrivateKey(String private){
    myPrivateKey = private;
  }
  void initUsers(List<User> users){
    this.users = users;
  }
  void initUserName(String username){
    this.username = username;
    notifyListeners();
  }
  void initMessageList(){
    this.messages = List<ExtendedMessage>();
    notifyListeners();
  }
  void initChannel(String channel){
    this.channel = channel;
    if(channel!= null){
      socketIO = SocketIOManager().createSocketIO(
          socketServer, '/',
          query: 'chatID=$channel');
      socketIO.init();
      socketIO.subscribe('receive_message', (jsonData) async {
        Map<String, dynamic> data = json.decode(jsonData);
        print("jsonData : ");
        print(jsonData);
        Message message = Message(
            data['content'], data['senderChatID'], data['receiverChatID'],new DateTime.fromMicrosecondsSinceEpoch(data['sentAt']));
        if(!isAsync) {
          ;
          messages.add(ExtendedMessage(message.text, message.senderID, message.receiverID,message.date,message.text,"",""));
        }else{
          for(User user in users){
            if(user.username == message.senderID){
              Message m = await AsymmetricUtil.decrypt(message, user.publicKey, myPrivateKey);
              messages.add(m);
              break;
            }
          }

        }
        discussions = getDiscussions();
        notifyListeners();
      });
      socketIO.connect();
      initialized = true;
      notifyListeners();
    }
  }

  void disconnect()  {

    initialized = false;
    socketIO.disconnect();
    notifyListeners();
  }
  void sendMessage(String text, String receiverChatID,{isAsync = false}) async {
    var originalText = text ;
    if(isAsync){

      for(User user in users){
        if(user.username == receiverChatID){
          text = await AsymmetricUtil.encryptAndSign(text,user.publicKey,myPrivateKey);
          break;
        }
      }
    }
    messages.add(ExtendedMessage(text, username, receiverChatID,DateTime.now(),originalText,"",""));
    discussions = getDiscussions();
    socketIO.sendMessage(
      'send_message',
      json.encode({
        'receiverChatID': receiverChatID,
        'senderChatID': username,
        'content': text,
      }),
    );
    notifyListeners();
  }


  List<ExtendedMessage> getMessagesForChatID(String chatID) {
    return messages
        .where((msg) => msg.senderID == chatID || msg.receiverID == chatID)
        .toList();
  }

  List<ExtendedMessage> getDiscussions() {
    List<ExtendedMessage> temp = new List();
    for(var m in  messages.reversed){
      var other = m.senderID==username?m.receiverID:m.senderID;
      bool flag = true;
      for(var v in temp){
        if(v.senderID==other||v.receiverID==other){
          flag = false;
          break;
        }
      }
      if(flag) temp.add(m);
    }
    return temp;
  }
}