import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:security/util/CustomEncoder.dart';
import 'package:security/util/CustomHashingFunctions.dart';
import 'package:security/util/SymmetricUtil.dart';
import 'package:security/util/messaging/Message.dart';
import 'package:security/util/messaging/messagingService.dart';
import 'package:security/util/styling/Text.dart';
import 'package:security/util/Extensions.dart';
import 'package:security/widget/TextInput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MessageDetailsSymUI.dart';
class ChatRoomUI extends StatefulWidget {

  final String room; final String password;
  ChatRoomUI(this.room,this.password);

  @override
  _ChatRoomUIState createState() => _ChatRoomUIState();
}

class _ChatRoomUIState extends State<ChatRoomUI> {

  TextEditingController _message = TextEditingController();
  String userName;
  @override
  void initState() {
    super.initState();
      initRoom()  ;
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to leave this room'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: ()  {
              Navigator.of(context).pop(true);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(2, 55, 71, 1),
            title: Text("ChatRoom: ${Provider
                .of<MessagingService>(context)
                .channel}"),
          ),
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(2, 55, 71, 1),
                        Color.fromRGBO(1, 30, 40, 1),
                        Color.fromRGBO(1, 22, 28, 1)
                      ])),
              child: Center(
                  child: _getBody(context)
              ),

            ),
          )
      ),
    );


  }

  _getBody(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            right: 0,
            left: 0,
            bottom: 80,
            top: 0,
            child: Container(
                child: _getMessageList())),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            child: Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: buildCustomInputField(true,"write something", _message, 60,false,false,this)),
                IconButton(icon: Icon(Icons.send,color: Colors.blue,), onPressed: _sendMessage)
              ],
            ),
          ),
        ),
      ],
    );
  }


  void initRoom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.get('username');
    Provider.of<MessagingService>(context,listen: false).initUserName(userName);
    Provider.of<MessagingService>(context,listen: false).initChannel(widget.room);
    Provider.of<MessagingService>(context,listen: false).initMessageList();
  }


  void _sendMessage() {
    Provider.of<MessagingService>(context,listen: false).sendMessage(SymmetricUtil.encrypt("", _message.text.toString(), widget.password),widget.room);
    _message.text = "";
  }


  Widget _getMessageList(){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        reverse: true,
        scrollDirection: Axis.vertical,
          itemCount: Provider.of<MessagingService>(context).messages.length,
          itemBuilder: itemBuilder),
    );
  }
  Widget _getListItemOther(Message message){
    var format = DateFormat(DateFormat.HOUR24_MINUTE);
    var dateString = format.format(message.date);
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.senderID,
              style: TextStyle(color: Colors.white),
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .6),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Color(0xfff9f9f9),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Text(
                SymmetricUtil.decrypt("", message.text, widget.password),
                style: Theme.of(context).textTheme.body1.apply(
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 15),
        Text(
          dateString,
          style: Theme.of(context).textTheme.body2.apply(color: Colors.grey),
        ),
      ],
    );
  }
  Widget _getListItemMe(Message message){
    var format = DateFormat(DateFormat.HOUR24_MINUTE);
    var dateString = format.format(message.date);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          dateString,
          style: Theme.of(context).textTheme.body2.apply(color: Colors.grey),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "",
              style: TextStyle(color: Colors.white),
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .6),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Text(
    SymmetricUtil.decrypt("", message.text, widget.password),
                style: Theme.of(context).textTheme.body1.apply(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),


      ],
    );
  }


  Widget itemBuilder(BuildContext context, int index) {
    Message message = Provider.of<MessagingService>(context,listen: false).messages.reversed.elementAt(index);
    Widget mess;
    if(message.senderID==userName)  mess =  _getListItemMe(message);
    else mess = _getListItemOther(message);
    return GestureDetector(
      child: mess,
      onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MessageDetailSymUI(message:message,password:widget.password)),
      );
    },);
  }
}

