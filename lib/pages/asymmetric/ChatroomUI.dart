import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:security/util/messaging/Message.dart';
import 'package:security/util/messaging/messagingService.dart';
import 'package:security/widget/TextInput.dart';

import 'MessageDetailsAsymUI.dart';

class DiscussionUI extends StatefulWidget {

  final String person;  final String username; final String publicKey;
  DiscussionUI(this.person,this.username,this.publicKey);

  @override
  _DiscussionUIState createState() => _DiscussionUIState();
}

class _DiscussionUIState extends State<DiscussionUI> {

  TextEditingController _message = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(80, 0, 0, 1),
          title: Text("${widget.person}"),
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(80, 0, 0, 1),
                      Color.fromRGBO(20, 0, 0, 1),
                      Color.fromRGBO(15, 0, 0, 1)
                    ])),
            child: Center(
                child: _getBody(context)
            ),

          ),
        )
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
                IconButton(icon: Icon(Icons.send,color: Colors.red,), onPressed: _sendMessage)
              ],
            ),
          ),
        ),
      ],
    );
  }


  void _sendMessage() async {
    Provider.of<MessagingService>(context,listen: false).sendMessage(_message.text,widget.person,isAsync: true);
    _message.text = "";
  }


  Widget _getMessageList(){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        reverse: true,
        scrollDirection: Axis.vertical,
          itemCount: Provider.of<MessagingService>(context).getMessagesForChatID(widget.person).length,
          itemBuilder: itemBuilder),
    );
  }
  Widget _getListItemOther(ExtendedMessage message){
    var format = DateFormat(DateFormat.HOUR24_MINUTE);
    var dateString = format.format(message.date);
    return GestureDetector(
      onTap: (){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MessageDetailAsymUI(message:message,publicKey: widget.publicKey,)),
        );
      },
      child: Row(
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
                  message.message,
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
      ),
    );
  }
  Widget _getListItemMe(ExtendedMessage message){
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
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Text(
                message.message,
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
    Message message = Provider.of<MessagingService>(context,listen: false).getMessagesForChatID(widget.person).reversed.elementAt(index);
    Widget mess;
    if(message.senderID==widget.username)  mess =  _getListItemMe(message);
    else mess = _getListItemOther(message);
    return mess;

  }
}

