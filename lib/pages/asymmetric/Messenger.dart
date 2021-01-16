import 'dart:convert';

import 'package:fast_rsa/model/bridge.pb.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:security/api/config.dart';
import 'package:security/api/model/users.dart';
import 'package:security/pages/asymmetric/ChatroomUI.dart';
import 'package:security/util/CustomEncoder.dart';
import 'package:security/util/CustomHashingFunctions.dart';
import 'package:security/util/SymmetricUtil.dart';
import 'package:security/util/messaging/Message.dart';
import 'package:security/util/messaging/messagingService.dart';
import 'package:security/util/styling/Text.dart';
import 'package:security/util/Extensions.dart';
import 'package:security/widget/ButtonBuilder.dart';
import 'package:security/widget/TextInput.dart';
import 'package:fast_rsa/rsa.dart';
import 'package:security/widget/dialog/UserListDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MessengerUI extends StatefulWidget {
  @override
  _MessengerUIState createState() => _MessengerUIState();
}

class _MessengerUIState extends State<MessengerUI> {


  List<User> users = List();
  String userName;
  @override
  void initState() {
    super.initState();
    _loadListOfUsers();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(80, 0, 0, 1),
          title: Text("Messenger"),
        ),
    floatingActionButton: FloatingActionButton(
    child: Icon(Icons.add),
    backgroundColor: Colors.red,
    onPressed: users.isEmpty?null:()=>_showUserList()),

        body: Container(
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

        )
    );
  }

  _getBody(BuildContext context) {
    return _getListOfDiscussions();
  }





  void _loadListOfUsers() async {
    toast("Loading Keys from KeyServer ... ");
    http.get(baseUrl + "asy/keys").then((http.Response res) {
      if (res.statusCode == 200) toast("keys loaded successfully");
      users = usersFromJson(res.body).data;
      initRoom();
      setState(() {
      });
    }).catchError((onError) {
      toast(onError.toString());
    });
  }




  Null _showUserList(){
    showDialog(
      context: context,
      builder: (BuildContext context) => UserListDialog(
        callback: (person){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiscussionUI(person,userName,_getPublicKey(person))),
          );
        },
        users: users,
      ),
    );
  }

  void initRoom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.get('username');
    Provider.of<MessagingService>(context,listen: false).initUserName(userName);
    Provider.of<MessagingService>(context,listen: false).initChannel(userName);
    Provider.of<MessagingService>(context,listen: false).initIsAsync(true);
    Provider.of<MessagingService>(context,listen: false).initUsers(users);
    Provider.of<MessagingService>(context,listen: false).initMessageList();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Provider.of<MessagingService>(context,listen: false).initPrivateKey(preferences.getString('privateKey'));
  }


  _getListOfDiscussions(){

    return ListView.builder(
        itemCount:Provider.of<MessagingService>(context).discussions.length ,
        itemBuilder: discussionItemBuilder);
  }

  Widget discussionItemBuilder(BuildContext context, int index) {
    ExtendedMessage message = Provider.of<MessagingService>(context).discussions.elementAt(index);
    String sender = message.senderID==userName?message.receiverID:message.senderID;
    var format = DateFormat(DateFormat.HOUR24_MINUTE);
    var dateString = format.format(message.date);
    return Container(
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiscussionUI(sender,userName,_getPublicKey(sender))),
          );
        },
        child: Card(
          color: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(message.senderID,style: buttonStyle,),
                    Text(dateString,style: buttonStyle.copyWith(fontSize: 15),)
                  ],
                ),
                Text(message.message,style: buttonStyle.copyWith(fontSize: 15),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getPublicKey(String userName) {
    for(User user in users){
      if(user.username == userName){
        return user.publicKey;
      }
    }
    return "";
  }
}

