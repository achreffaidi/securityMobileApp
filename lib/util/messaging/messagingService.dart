import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:security/api/config.dart';

import 'Message.dart';

class MessagingService extends ChangeNotifier {

  bool hasKeys = false;
  bool initialized = false;
  String channel;
  String username;
  SocketIO socketIO;
  List<Message> messages = List<Message>();

  void initUserName(String username){
    this.username = username;
    notifyListeners();
  }
  void initMessageList(){
    this.messages = List<Message>();
    notifyListeners();
  }
  void initChannel(String channel){
    this.channel = channel;
    if(channel!= null){
      socketIO = SocketIOManager().createSocketIO(
          socketServer, '/',
          query: 'chatID=$channel');
      socketIO.init();
      socketIO.subscribe('receive_message', (jsonData) {
        Map<String, dynamic> data = json.decode(jsonData);
        print("jsonData : ");
        print(jsonData);
        messages.add(Message(
            data['content'], data['senderChatID'], data['receiverChatID'],new DateTime.fromMicrosecondsSinceEpoch(data['sentAt'])));
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
  void sendMessage(String text, String receiverChatID) {
    messages.add(Message(text, username, receiverChatID,DateTime.now()));
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


  List<Message> getMessagesForChatID(String chatID) {
    return messages
        .where((msg) => msg.senderID == chatID || msg.receiverID == chatID)
        .toList();
  }
}